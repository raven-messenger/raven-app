package tk.ravenmessenger;

import android.graphics.Bitmap;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.util.Log;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

public class QrCode {

    public static final String TAG = QrCode.class.getSimpleName();

    @NonNull
    public static Bitmap create(String data) {
        try {
            BitMatrix result = new QRCodeWriter().encode(data, BarcodeFormat.QR_CODE, 512, 512);
            Bitmap bitmap = Bitmap.createBitmap(result.getWidth(), result.getHeight(), Bitmap.Config.ARGB_8888);

            for (int y = 0; y < result.getHeight(); y++) {
                for (int x = 0; x < result.getWidth(); x++) {
                    if (result.get(x, y)) {
                        bitmap.setPixel(x, y, Color.BLACK);
                    }
                }
            }

            return bitmap;
        } catch (WriterException e) {
            Log.w(TAG, e);
            return Bitmap.createBitmap(512, 512, Bitmap.Config.ARGB_8888);
        }
    }

}

