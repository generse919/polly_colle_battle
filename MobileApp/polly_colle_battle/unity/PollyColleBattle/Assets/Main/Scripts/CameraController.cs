using UnityEngine;

public class CameraController : MonoBehaviour
{

    public Transform target; // 追従対象のオブジェクト
    public float distance = 1.0f; // カメラとオブジェクトの距離
    public float height = 3.0f; // カメラの高さ
    public float smoothSpeed = 5.0f; // 追従のスムーズさ

    private Vector3 offset; // カメラの位置オフセット

    void Start()
    {
        // カメラの初期位置を設定
        offset = new Vector3(distance, height, 0);
    }

    void LateUpdate()
    {
        if (target == null)
        {
            return; // 追従対象が設定されていない場合は何もしない
        }

        // 追従対象の位置に対してオフセットを適用し、目標位置を計算
        Vector3 targetPosition = target.position + offset;

        // カメラの位置をスムーズに変更
        transform.position = Vector3.Lerp(transform.position, targetPosition, smoothSpeed * Time.deltaTime);

        // カメラが追従対象を向くようにする
        transform.LookAt(target);
    }
}