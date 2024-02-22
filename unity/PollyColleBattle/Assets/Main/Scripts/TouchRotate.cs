using UnityEngine;

public class TouchRotate : MonoBehaviour
{
    Rigidbody rb;
    // Start is called before the first frame update


    //回転アクションに必要なもの
    private Quaternion lastRotation;
    private float rotationSpeed;

    //Vの最小値
    private float minV = 50.0f / 100.0f;
    private float pointRotationSpeed = 10000.0f;
    private float maxRotationSpeed = 25000.0f;

    void Start()
    {
        //Rigidbodyを取得
        rb = GetComponent<Rigidbody>();
    }

    void Update()
    {
        touchAction();
        changeBackgroundColor();
    }
    /// <summary>
    /// タッチされた時の処理
    /// </summary>
    /// <returns></returns>
    void touchAction()
    {
        //タッチされたらレイを飛ばす
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit))
            {
                //タッチされたオブジェクトが自分自身だったら
                Debug.Log(hit.collider.gameObject);
                if (hit.collider.gameObject == this.gameObject)
                {
                    Debug.Log("Hit");
                    //タッチした方向に力を加えて回転させる
                    Vector3 force = new Vector3(hit.point.x - transform.position.x, 0, hit.point.z - transform.position.z);
                    rb.AddTorque(force * 100);
                }
            }
        }
    }

    private void FixedUpdate()
    {
        updateRotationInfo();
    }

    void updateRotationInfo()
    {
        // Calculate the difference in rotation during the last frame
        Quaternion deltaRotation = transform.rotation * Quaternion.Inverse(lastRotation);

        // Convert the rotation difference to Euler angles and get the magnitude
        rotationSpeed = deltaRotation.eulerAngles.magnitude / Time.fixedDeltaTime;

        // Store the current rotation for the next frame
        lastRotation = transform.rotation;

        // Debug.Log("Rotation Speed: " + rotationSpeed);
    }
    /// <summary>
    /// 背景色を変化させていく
    /// </summary>
    /// <returns></returns>
    void changeBackgroundColor()
    {
        float H, S, V = S = H = 0.0f;

        Color.RGBToHSV(Camera.main.backgroundColor, out H, out S, out V);

        // float newColorH = (rotationSpeed > pointRotationSpeed) ? Mathf.Repeat(H + 0.001f, 1.0f) : Mathf.Repeat(H, 1.0f);
        // float newColorS = Mathf.Clamp(rotationSpeed/ pointRotationSpeed, 67.0f/100.0f, 1.0f);
        // float newColorV = minV;

        // float newColorH = 1.0f - Mathf.Clamp(rotationSpeed / maxRotationSpeed, 140.0f/ 360.0f, 1.0f);
        // float newColorS = Mathf.Clamp(rotationSpeed/ pointRotationSpeed, 67.0f/100.0f, 1.0f);
        float newColorV = Mathf.Clamp(rotationSpeed / maxRotationSpeed, minV, 1.0f);
        //背景色を変化させていく
        Camera.main.backgroundColor = Color.HSVToRGB(H, S, newColorV);
    }
}
