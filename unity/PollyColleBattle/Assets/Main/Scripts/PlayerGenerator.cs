using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UniRx;
[RequireComponent(typeof(ModelGenerator))]
public class PlayerGenerator : MonoBehaviour
{
    ModelGenerator mg;

    public enum PLAYER_INDEX
    {
        PLAYER_1 = 0,
        PLAYER_2,
        PLAYER_INVALID
    }

    public PLAYER_INDEX playerIndex;
    // Start is called before the first frame update
    void Start()
    {
        mg = GetComponent<ModelGenerator>();
        this
            .ObserveEveryValueChanged(self => self.transform.GetComponentInChildren<MeshFilter>())
            .Subscribe(onChangeMesh);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
    /// <summary>
    /// モデル生成後、PlayerControllerを付与
    /// </summary>
    /// <param name="newVal"></param>
    void onChangeMesh(MeshFilter newFilter)
    {
        Debug.Log("changeMesh");
        var child = GetComponentInChildren<MeshRenderer>();
        if (child == null) return;
        var pc = child.gameObject.AddComponent<PlayerController>();
        pc.userIndex = ((int)playerIndex);

    }

}
