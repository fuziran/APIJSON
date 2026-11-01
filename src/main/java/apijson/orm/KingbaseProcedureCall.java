/*Copyright (C) 2026 the APIJSON group. All rights reserved.
This source code is licensed under the Apache License Version 2.0.*/
package apijson.orm;

import apijson.StringUtil;
import apijson.orm.AbstractFunctionParser.FunctionBean;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/** Ordinary IN values only. Never interpret a value as a SQL fragment. */
final class KingbaseProcedureCall {
	private static final Pattern NAME = Pattern.compile("[A-Za-z_][0-9A-Za-z_]*");
	private static final Pattern NUMBER = Pattern.compile("[+-]?(?:[0-9]+(?:\\.[0-9]*)?|\\.[0-9]+)(?:[eE][+-]?[0-9]+)?");
	private final String schema;
	private final String name;
	private final List<Object> arguments;

	KingbaseProcedureCall(String qualifiedName, List<Object> values) {
		if (qualifiedName == null) throw new IllegalArgumentException("Procedure name is required");
		int dot = qualifiedName.indexOf('.');
		schema = dot < 0 ? null : AbstractFunctionParser.extractSchema(qualifiedName.substring(0, dot), null);
		name = dot < 0 ? qualifiedName : qualifiedName.substring(dot + 1);
		if (dot == 0 || !NAME.matcher(name).matches()) throw new IllegalArgumentException("Invalid procedure name: " + qualifiedName);
		List<Object> copy = values == null ? new ArrayList<>() : new ArrayList<>(values);
		for (Object value : copy) {
			if (value != null && !(value instanceof String || value instanceof Number || value instanceof Boolean)) {
				throw new IllegalArgumentException("Kingbase procedure IN arguments must be scalar values or null");
			}
			if (value instanceof Double && !Double.isFinite((Double) value)
					|| value instanceof Float && !Float.isFinite((Float) value)) {
				throw new IllegalArgumentException("Procedure numeric arguments must be finite");
			}
		}
		arguments = Collections.unmodifiableList(copy);
	}

	static List<Object> arguments(FunctionBean function, Map<String, Object> current, boolean raw) {
		if (raw) throw new IllegalArgumentException("Raw SQL is not supported in Kingbase procedure arguments");
		String expression = function.getFunction();
		String body = expression.substring(expression.indexOf('(') + 1, expression.lastIndexOf(')'));
		List<Object> values = new ArrayList<>();
		if (body.trim().isEmpty()) return values;
		for (String item : body.split(",", -1)) {
			String key = item.trim();
			if (key.isEmpty()) throw new IllegalArgumentException("Empty procedure argument expression");
			Object value;
			if (key.startsWith("`") && key.endsWith("`") && key.length() > 2
					&& key.substring(1, key.length() - 1).indexOf('`') < 0) {
				value = current.get(key.substring(1, key.length() - 1));
			} else if (key.startsWith("'") && key.endsWith("'") && key.length() >= 2) {
				value = key.substring(1, key.length() - 1);
			} else if (StringUtil.isName(key.startsWith("@") ? key.substring(1) : key)) {
				if (current.containsKey(key)) value = current.get(key);
				else if ("true".equals(key) || "false".equals(key)) value = Boolean.valueOf(key);
				else value = null;
			} else if (NUMBER.matcher(key).matches()) {
				value = key.indexOf('.') >= 0 || key.indexOf('e') >= 0 || key.indexOf('E') >= 0
						? new BigDecimal(key) : new BigInteger(key);
			} else {
				throw new IllegalArgumentException("Unsupported procedure argument expression: " + key);
			}
			values.add(value);
		}
		return values;
	}

	List<Object> getArguments() { return arguments; }

	String invocation() {
		StringBuilder call = new StringBuilder(schema == null ? "" : schema + ".").append(name).append('(');
		for (int i = 0; i < arguments.size(); i++) call.append(i == 0 ? "?" : ",?");
		return call.append(')').toString();
	}

	String sql(SQLConfig<?, ?, ?> config) {
		String selectedSchema = schema == null ? config.gainSQLSchema() : schema;
		String q = config.getQuote();
		String call = (StringUtil.isEmpty(selectedSchema, true) ? "" : q + selectedSchema + q + ".")
				+ invocation().substring(schema == null ? 0 : schema.length() + 1);
		return config.isKingBaseOracle() ? "BEGIN " + call + "; END;" : "CALL " + call;
	}
}
