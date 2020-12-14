public class Eng_STCalculationIdService {
    
    public static Integer getPID(sObject obj, sObjectField calcField)
    {
        return Eng_STCalculationIdService.getSuperTrumpPid(obj, calcField);
    }
    
    private static Integer getSuperTrumpPid(sObject sObj, sObjectField calcField)
    {
        Object calcId = sObj.get(calcField);
        if (calcId instanceof String && calcId != null)
        {
            Pattern pidPattern = Pattern.compile('^(.+[^\\d])(\\d+)$');
            Matcher pidMatcher = pidPattern.matcher((String) calcId);
            if (pidMatcher.matches() && pidMatcher.hitEnd())
            {
                String pidString = pidMatcher.group(2);
                if (pidString != null && pidString.length() > 0)
                {
                    return Integer.valueOf(pidString);
                }
            }
        }
        return null;
    }
}