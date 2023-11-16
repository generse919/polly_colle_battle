using UnityEngine;
using UniRx;
using UnityEditor;

#if UNITY_EDITOR
[ExecuteInEditMode]
#endif
public class ModelGenerator : MonoBehaviour
{
    [SerializeField]
    GameObject _avaterModel;

    [SerializeField]
    Material mat_vertexColorApply;

    GameObject _avaterInstance;

    // Start is called before the first frame update
    void Start()
    {

        RefreshModel();
        this
           .ObserveEveryValueChanged(self => self._avaterModel)
           .Skip(1) // 初回は無視
           .Subscribe(OnModelChanged)
           .AddTo(gameObject);

    }

    private void OnModelChanged(GameObject o)
    {

        Debug.Log("ValueChanged" + o);

        foreach (var child in GetComponentsInChildren<Transform>())
        {
            if (child == null || child == transform || child.gameObject == null) continue;
#if UNITY_EDITOR

            if (EditorApplication.isPlayingOrWillChangePlaymode)
            {
                Destroy(child.gameObject);
            }
            else
            {
                DestroyImmediate(child.gameObject);
            }
#else

            Destroy(child.gameObject);
#endif

        }


        _avaterInstance = Instantiate(o, transform);

        var meshRenderer = _avaterInstance.GetComponentInChildren<MeshRenderer>();

        meshRenderer.material = mat_vertexColorApply;
    }


    private void RefreshModel()
    {
#if UNITY_EDITOR
        OnModelChanged(_avaterModel);
#endif
    }




}
