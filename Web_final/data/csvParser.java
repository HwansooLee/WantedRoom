import java.io.BufferedReader;
import java.util.Arrays;
import java.util.List;

public class csvParser {


    public static void main(String[] args) {
        List<List<String>> stores = new ArrayList<>();
        BufferedReader br = new BufferedReader(new FileReader("storeData.csv"));
        String line;
        while( (line = br.readLine()) != null ){
            String[] values = line.split(",");
            stores.add(Arrays.asList(values));
        }
        for(String s:stores.get(0)){
            System.out.print(s + " ");
        }
    }
}
