public class RankingWrapper implements Comparable{
    public String name { get; set; }
    public Id personId { get; set; }
    public String role { get; set; }
    public String seniority { get; set; }
    public String color { get; set; }
    public Decimal testPromResults { get; set; }
    
    public RankingWrapper(String nameRanking, Id personIdRanking, String roleRanking, String seniorityRanking, String colorRanking, Decimal testPromResultsRanking){
        name = nameRanking;
        personId = personIdRanking;
        role = roleRanking;
        seniority = seniorityRanking;
        color = colorRanking;
        testPromResults = testPromResultsRanking;
    }
    
    public Integer compareTo(Object compareTo) {
        RankingWrapper compareToRW = (RankingWrapper)compareTo;
        if (testPromResults == compareToRW.testPromResults) return 0;
        if (testPromResults < compareToRW.testPromResults) return 1;
        return -1;
    }
    

}