using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Smash : MonoBehaviour
{
    Rigidbody rb;
    [Header("Õ“Ë‘¬“xŒW”")]
    public float speedRateX = 1.0f;
    public float speedRateY = 1.0f;

    // Start is called before the first frame update
    void Start()
    {
        //sc = GetComponent<SphereCollider>();
        rb = gameObject.GetComponent<Rigidbody>();
    }

    public void AddSmashForce(Vector3 force)
    {

        if (rb.velocity != new Vector3(0, 0, 0)) return;
        rb.useGravity = false;
        rb.isKinematic = false;
        var forceXY = new Vector3(force.x * speedRateX, force.y * speedRateY, 0);
        rb.AddForce(forceXY);
        Debug.Log("Add Force" + force);
        
    }
    //2023.05.10
    //@author Yamamoto.S
    //ƒŒƒCƒ„[•Ï‰»‚ÅPlayer‚Æ‚ÌÚG‚ğ‚È‚­‚·
    public void PlayerTouchDisable()
    {
        gameObject.layer = LayerMask.NameToLayer("GameEffect");
    }
}
