using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// モデルの乗っているテーブルを回転させる。
/// </summary>
public class ModelViewRotationTable : MonoBehaviour
{

    public float RotationSpeed = 30.0f;


    // Update is called once per frame
    void Update()
    {
        transform.Rotate(new Vector3(0, RotationSpeed * Time.deltaTime, 0), Space.Self);
    }
}
