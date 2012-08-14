import java.io.*;
import java.net.*;

public class JavaExample {
    public static void main(String[] args) throws Exception{
        String document = "<html><body>This is a DocRaptor Example</body></html>";
        String apikey = "YOUR_API_KEY_HERE";
        String data = "doc[document_content]=" + document;
        data += "&doc[name]=java_sample.pdf";
        data += "&doc[document_type]=pdf";
        data += "&doc[test]=true";
        
        byte[] encodedData = data.getBytes("UTF8");
        
        String url = "https://docraptor.com/docs?user_credentials=" + apikey;
        String agent = "Mozilla/4.0";
        String type = "application/x-www-form-urlencoded";
        
        HttpURLConnection conn = (HttpURLConnection)new URL(url).openConnection();
        conn.setDoOutput(true); // send as a POST
        conn.setRequestProperty("User-Agent", agent);
        conn.setRequestProperty("Content-Type", type);
        conn.setRequestProperty("Content-Length", Integer.toString(encodedData.length));

        OutputStream os = conn.getOutputStream();
        os.write(encodedData);
        os.flush();

        InputStream responseStream = conn.getInputStream();
        OutputStream outputStream = new FileOutputStream(new File("java_sample.pdf"));
        byte[] buffer = new byte[1024];
        int len;
        while((len = responseStream.read(buffer)) > 0) {
            outputStream.write(buffer, 0, len);
        }
        responseStream.close();
        outputStream.close();
    }
}
