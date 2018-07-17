//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package ljh.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Dictionary;
import java.util.Hashtable;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;

public class FileUploadBean {
    private String savePath;
    private String filepath;
    private String filename;
    private String contentType;
    private Dictionary fields;
    private String CharacterEncoding = null;
    private String ContentType = "";
    private static String newline = " ";
    private String newFilename = "";

    public FileUploadBean() {
    }

    public String getFilename() {
        return this.filename;
    }

    public String getFilepath() {
        return this.filepath;
    }

    public void setSavePath(String savePath) {
        this.savePath = savePath;
    }

    public String getContentType() {
        return this.contentType;
    }

    public String getFieldValue(String fieldName) {
        return this.fields != null && fieldName != null ? (String)this.fields.get(fieldName) : null;
    }

    private void setFilename(String s) {
        if (s != null) {
            int pos = s.indexOf("filename=");
            if (pos != -1) {
                this.filepath = s.substring(pos + 10, s.length() - 1);
                pos = this.filepath.lastIndexOf("\\");
                if (pos != -1) {
                    this.filename = this.filepath.substring(pos + 1);
                } else {
                    this.filename = this.filepath;
                }
            }

        }
    }

    private void setContentType(String s) {
        if (s != null) {
            int pos = s.indexOf(": ");
            if (pos != -1) {
                this.contentType = s.substring(pos + 2, s.length());
            }

        }
    }

    public void doUpload(HttpServletRequest request) throws IOException {
        ServletInputStream in = request.getInputStream();
        byte[] line = new byte[256];
        String s5 = null;
        byte[] Linebyte = new byte[409600];
        byte[] outLinebyte = new byte[409600];
        int[] ai = new int[1];
        int[] ai1 = new int[1];
        ServletInputStream servletinputstream = request.getInputStream();
        int i = in.readLine(line, 0, 25600);
        if (i >= 3) {
            int boundaryLength = i - 2;
            String boundary = new String(line, 0, boundaryLength);

            for(this.fields = new Hashtable(); i != -1; i = in.readLine(line, 0, 256)) {
                String newLine = new String(line, 0, i);
                if (newLine.startsWith("Content-Disposition: form-data; name=")) {
                    if (newLine.indexOf("filename=") != -1) {
                        this.setFilename(new String(line, 0, i - 2));
                        if (this.filename == null) {
                            return;
                        }

                        if (this.filename != null && !this.filename.equals("\"")) {
                            this.filename = this.getFileName(this.filename);
                            String sContentType = this.readLine(Linebyte, ai, servletinputstream, this.CharacterEncoding);
                            if (sContentType.indexOf("Content-Type") >= 0) {
                                this.readLine(Linebyte, ai, servletinputstream, this.CharacterEncoding);
                            }

                            File file = null;
                            if (this.newFilename != null && !this.newFilename.equals("")) {
                                String extend = this.filename.substring(this.filename.indexOf(".")).toLowerCase();
                                file = new File(this.savePath, this.newFilename + extend);
                                this.filename = this.newFilename + extend;
                            }

                            System.out.println(file);

                            FileOutputStream fileoutputstream = new FileOutputStream(file);

                            while((sContentType = this.readLine(Linebyte, ai, servletinputstream, this.CharacterEncoding)) != null) {
                                if (s5 != null) {
                                    fileoutputstream.write(outLinebyte, 0, ai1[0]);
                                    fileoutputstream.flush();
                                }

                                s5 = this.readLine(outLinebyte, ai1, servletinputstream, this.CharacterEncoding);
                                fileoutputstream.write(Linebyte, 0, ai[0]);
                                fileoutputstream.flush();
                            }

                            byte byte0;
                            if (newline.length() == 1) {
                                byte0 = 2;
                            } else {
                                byte0 = 1;
                            }

                            if (s5 != null && outLinebyte[0] != 45 && ai1[0] > newline.length() * byte0) {
                                fileoutputstream.write(outLinebyte, 0, ai1[0] - newline.length() * byte0);
                            }

                            if (sContentType != null && Linebyte[0] != 45 && ai[0] > newline.length() * byte0) {
                                fileoutputstream.write(Linebyte, 0, ai[0] - newline.length() * byte0);
                            }

                            fileoutputstream.close();
                        }
                    } else {
                        int pos = newLine.indexOf("name=");
                        String fieldName = newLine.substring(pos + 6, newLine.length() - 3);
                        in.readLine(line, 0, 128);
                        i = in.readLine(line, 0, 128);
                        newLine = new String(line, 0, i);

                        StringBuffer fieldValue;
                        for(fieldValue = new StringBuffer(128); i != -1 && !newLine.startsWith(boundary); newLine = new String(line, 0, i)) {
                            i = in.readLine(line, 0, 128);
                            if ((i == boundaryLength + 2 || i == boundaryLength + 4) && (new String(line, 0, i)).startsWith(boundary)) {
                                fieldValue.append(newLine.substring(0, newLine.length() - 2));
                            } else {
                                fieldValue.append(newLine);
                            }
                        }

                        this.fields.put(fieldName, fieldValue.toString());
                    }
                }
            }

            this.newFilename = "";
        }
    }

    public void saveAs(String name) throws IOException {
        this.newFilename = name;
    }

    private String readLine(byte[] Linebyte, int[] ai, ServletInputStream servletinputstream, String CharacterEncoding) {
        try {
            ai[0] = servletinputstream.readLine(Linebyte, 0, Linebyte.length);
            if (ai[0] == -1) {
                return null;
            }
        } catch (IOException var7) {
            return null;
        }

        try {
            return CharacterEncoding == null ? new String(Linebyte, 0, ai[0]) : new String(Linebyte, 0, ai[0], CharacterEncoding);
        } catch (Exception var6) {
            return null;
        }
    }

    private String getFileName(String s) {
        int i = s.lastIndexOf("\\");
        if (i < 0 || i >= s.length() - 1) {
            i = s.lastIndexOf("/");
            if (i < 0 || i >= s.length() - 1) {
                return s;
            }
        }

        return s.substring(i + 1);
    }
}
