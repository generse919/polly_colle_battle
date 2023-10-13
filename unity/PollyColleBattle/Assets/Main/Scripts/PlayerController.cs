using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody))]
public class PlayerController : MonoBehaviour
{
    Rigidbody rb;
    Vector3 force;//移動する速さ
    Vector3 dragPos = Vector3.zero;//タッチ開始位置
    [Header("引っ張った時の速さ")]
    [SerializeField]
    float speed = 100.0f;
    [SerializeField]
    LineRenderer lineRenderer;
    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        //クリック(タッチ)されたとき
        if (Input.GetMouseButtonDown(0))
        {
            dragPos = Input.mousePosition;
            lineRenderer.enabled = true;
        }
        //クリック(タッチ)されているとき
        if (Input.GetMouseButton(0))
        {
            //タッチ開始位置との差分を計算
            var touchDir = Input.mousePosition - dragPos;

            //マウス座標がXYで取得されるのでXZ平面へ変換
            touchDir.z = touchDir.y;
            touchDir.y = 0;
            //端末ごとに差が出ないようにスクリーンサイズで補正
            touchDir.x /= Screen.width;
            touchDir.z /= Screen.height;
            force = touchDir;

            //ガイドの方向を決める
            Vector3 LineDest = force * speed;
            if (LineDest.magnitude >= 20.0f)
            {
                LineDest *= 20.0f / LineDest.magnitude;
            }
            lineRenderer.SetPosition(0, rb.position);
            lineRenderer.SetPosition(1, rb.position - LineDest);

        }
        if (Input.GetMouseButtonUp(0))
        {
            //マウスドロップ?(画面から手を離したとき)
            rb.AddForce(-force * speed, ForceMode.Impulse);
            lineRenderer.enabled = false;
        }

    }

}