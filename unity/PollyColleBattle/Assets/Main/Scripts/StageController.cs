using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UniRx;

public class StageController : MonoBehaviour
{
    GameManager gm;

    [SerializeField]
    GameObject o_stageTile;

    [SerializeField]
    Material mat_lightTheme;
    [SerializeField]
    Material mat_darkTheme;

    // Start is called before the first frame update
    void Start()
    {
        gm = GameObject.Find("GameManager").GetComponent<GameManager>();
        gm
            .ObserveEveryValueChanged(_gm => _gm.isDarkMode)
            .Subscribe(flag => changeMat(flag));

        if (o_stageTile == null)
        {
            Debug.LogWarning("\"o_stageTile\" is set null!");
        }
    }

    // Update is called once per frame
    void Update()
    {

    }
    /// <summary>
    /// テーマが変更されたら呼び出されるメソッド
    /// </summary>
    /// <param name="flag"></param>
    void changeMat(bool flag)
    {
        o_stageTile.GetComponent<MeshRenderer>().material = (flag) ? mat_darkTheme : mat_lightTheme;
    }
}
