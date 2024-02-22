using UnityEngine;
using UniRx;
using UnityEngine.EventSystems;
[RequireComponent(typeof(ModelGenerator), typeof(PlayerData))]
public class PlayerGenerator : MonoBehaviour , IEventSystemHandler
{
    ModelGenerator mg;
    GameManager gm;

    public enum PLAYER_INDEX
    {
        PLAYER_1 = 0,
        PLAYER_2,
        PLAYER_INVALID
    }

    public PLAYER_INDEX playerIndex;

    public bool isAI = false;

    // Start is called before the first frame update
    void Start()
    {
        mg = GetComponent<ModelGenerator>();
        gm = FindObjectOfType<GameManager>();

        this
            .ObserveEveryValueChanged(self => self.transform.GetComponentInChildren<MeshFilter>())
            .Skip(1) // 初回は無視
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
        child.gameObject.tag = "Player";
        pc.userIndex = ((int)playerIndex);
        pc.isAI = isAI;
        pc.parentRoot = transform;
        pc.playerData = GetComponent<PlayerData>();

    }

}
