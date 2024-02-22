using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Rigidbody), typeof(MeshCollider), typeof(MeshDestroy))]
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

    private List<GameObject> contactedObjects = new List<GameObject>();


    public Transform parentRoot;
    [Header("引っ張った時の速さ")]
    [SerializeField]
    float speed = 100.0f;

    // 上向きに飛ぶときの力
    [SerializeField]
    float upForce = 5.0f;
    [SerializeField]
    LineRenderer lineRenderer;
    HSVParam startLineHSV = new HSVParam(255, 78, 30, 100);//最も弱いとき
    HSVParam destLineHSV = new HSVParam(0, 78, 30, 100);//最も強いとき

    public int userIndex = 0;

    public bool isAI = false;

    public PlayerData playerData;
    public Vector3 lastVelocity;
    // Start is called before the first frame update

    [SerializeField]
    MeshDestroy meshDestroy;
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        mc = GetComponent<MeshCollider>();
        meshDestroy = GetComponent<MeshDestroy>();
        gm = GameObject.FindWithTag("GameManager").GetComponent<GameManager>();
        lineRenderer = transform.parent.parent.GetComponent<LineRenderer>();
        lineRenderer.enabled = false;
        mc.convex = true;


        if (isAI)
        {
            StartCoroutine(AIAction());
        }

    }

    // Update is called once per frame
    void Update()
    {
        if (!isAI)
        {
            touchActions();

        }


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
            lineRenderer.endColor = Color.HSVToRGB(baseH / 360.0f, 95.0f / 100.0f, 100.0f / 100.0f);

        }
        if (Input.GetMouseButtonUp(0))
        {
            //マウスドロップ?(画面から手を離したとき)
            rb.AddForce(-force * speed, ForceMode.Impulse);
            lineRenderer.enabled = false;
        }
    }
    public IEnumerator AIAction()
    {
        while (true)
        {
            //1~3秒待つ
            yield return new WaitForSeconds(Random.Range(1.0f, 3.0f));
            rb.AddForce(new Vector3(Random.Range(-.1f, .1f), Random.Range(-.1f, .1f), Random.Range(-.1f, .1f)) * speed, ForceMode.Impulse);
        }
    }

    void FixedUpdate()
    {
        if(isAI) return;
        if (Input.GetMouseButtonDown(0) && GetContactedObjects().Count > 0)
        {
            Debug.Log("Jump");
            //Y軸正方向に力を加える
            rb.AddForce(Vector3.up * upForce, ForceMode.Impulse);
        }

        lastVelocity = rb.velocity;

    }

    private void OnCollisionEnter(Collision collision)
    {
        if (!contactedObjects.Contains(collision.gameObject) && collision.gameObject.tag == "Ground")
        {
            contactedObjects.Add(collision.gameObject);
        }

        if(collision.gameObject.tag == "Player")
        {
            // Calculate the force of the impact
            Vector3 impactForce = collision.rigidbody.mass * (lastVelocity - collision.rigidbody.velocity);

            playerData.playerHP -= impactForce.magnitude;

            Debug.Log("Impact Force: From " + collision.collider.name + impactForce.magnitude);

            if(playerData.playerHP <= 0)
            {
                Debug.Log("Player " + userIndex + " is dead");
                // meshDestroy.DestroyMesh();
            }
        }
    }

    private void OnCollisionExit(Collision collision)
    {
        contactedObjects.Remove(collision.gameObject);
    }

    public List<GameObject> GetContactedObjects()
    {
        return new List<GameObject>(contactedObjects);
    }



}