using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody), typeof(MeshCollider))]
public class PlayerController : MonoBehaviour
{

    struct HSVParam
    {
        public HSVParam(int h, int s, int v, int a)
        {
            this.h = h;
            this.s = s;
            this.v = v;
            this.a = a;
        }
        public int h;
        public int s;
        public int v;
        public int a;
    }



    Rigidbody rb;
    MeshCollider mc;
    GameManager gm;
    Vector3 force;//移動する速さ
    Vector3 dragPos = Vector3.zero;//タッチ開始位置
    [Header("引っ張った時の速さ")]
    [SerializeField]
    float speed = 100.0f;
    [SerializeField]
    LineRenderer lineRenderer;
    HSVParam startLineHSV = new HSVParam(255, 78, 30, 100);//最も弱いとき
    HSVParam destLineHSV = new HSVParam(0, 78, 30, 100);//最も強いとき

    public int userIndex = 0;
    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        mc = GetComponent<MeshCollider>();
        gm = GameObject.FindWithTag("GameManager").GetComponent<GameManager>();
        lineRenderer = transform.parent.parent.GetComponent<LineRenderer>();
        lineRenderer.enabled = false;
        mc.convex = true;
        
    }

    // Update is called once per frame
    void Update()
    {
        touchActions();

    }

    void touchActions()
    {

        if (gm.controlUseIndex != userIndex) return;
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
            var mag = LineDest.magnitude;
            if (mag >= 20.0f)
            {
                mag = 20.0f;
                LineDest *= 20.0f / mag;
            }
            lineRenderer.SetPosition(0, rb.position);
            lineRenderer.SetPosition(1, rb.position - LineDest);
            var baseH = Mathf.Repeat(Mathf.Min(startLineHSV.h, destLineHSV.h)
                + Mathf.Abs(startLineHSV.h - destLineHSV.h) * (mag / 20.0f), 360.0f);
            //色を変える
            lineRenderer.startColor = Color.HSVToRGB(baseH / 360.0f, 30.0f / 100.0f, 100.0f / 100.0f);
            lineRenderer.endColor = Color.HSVToRGB(baseH / 360.0f,95.0f / 100.0f, 100.0f/100.0f);

        }
        if (Input.GetMouseButtonUp(0))
        {
            //マウスドロップ?(画面から手を離したとき)
            rb.AddForce(-force * speed, ForceMode.Impulse);
            lineRenderer.enabled = false;
        }
    }

}