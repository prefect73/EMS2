package utils;

public enum DayOfWeek {

	MONTAG("Mo", 1), DIENSTAG("Di", 2), MITTWOCH("Mi", 3), DONNERSTAG("Do", 4), FREITAG("Fr", 5), SAMSTAG("Sa",
			6), SONNTAG("So", 7);

	private final String name;
	private final int dayOfWeek;

	private DayOfWeek(String name, int dayOfWeek) {
		this.name = name;
		this.dayOfWeek = dayOfWeek;
	}

	public static String getDayName(int dayOfWeek) {
		for (DayOfWeek day : DayOfWeek.values()) {
			if (day.dayOfWeek == dayOfWeek) {
				return day.name;
			}
		}
		return null;
	}

}
