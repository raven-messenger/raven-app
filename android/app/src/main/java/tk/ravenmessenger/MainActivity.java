package tk.ravenmessenger;

import android.graphics.Bitmap;
import android.os.Bundle;

import java.io.FileOutputStream;
import java.io.IOException;

import android.os.Environment;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "tk.ravenmessenger/genQR";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
                        if (methodCall.method.equals("genQR")) {
                            String fileName = methodCall.argument("fileName");
                            String value = methodCall.argument("value");
                            result.success(genSaveQR(fileName, value));
                        }
                    }
                }
        );
    }

    String genSaveQR(String fileName, String value) {
        Bitmap bmap = QrCode.create(value);
        String file_path = getFilesDir().getAbsolutePath() +
                "/" + fileName;
        FileOutputStream out = null;
        try {
            out = new FileOutputStream(file_path);
            bmap.compress(Bitmap.CompressFormat.PNG, 100, out); // bmp is your Bitmap instance
            // PNG is a lossless format, the compression factor (100) is ignored
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (out != null) {
                    out.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return file_path;
    }
}
