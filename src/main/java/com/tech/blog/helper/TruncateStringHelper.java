package com.tech.blog.helper;

public class TruncateStringHelper {
	public static String abbreviateString(String input, int maxLength) {
		if (input.length() <= maxLength)
			return input;
		else
			return input.substring(0, maxLength - 3) + "...";
	}
}