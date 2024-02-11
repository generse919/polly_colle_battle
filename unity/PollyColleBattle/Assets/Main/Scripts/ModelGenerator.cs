using UnityEngine;
using UniRx;
using UnityEditor;
using UnityEngine.Networking;
using System;
using System.Collections;
using System.IO;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using GLTFast;
using GLTFast.Materials;
using GLTFast.Logging;




//#if UNITY_EDITOR
//[ExecuteInEditMode]
//#endif
public class ModelGenerator : MonoBehaviour
{
    [SerializeField]
    GameObject _avaterModel;

    [SerializeField]
    UnityEngine.Material mat_vertexColorApply;

    [SerializeField]
    String ModelUrl = null;

    GameObject _avaterInstance;

    GltfImport _gltfImport = null;
    ImportSettings _settings;

    // Start is called before the first frame update
    void Start()
    {
        //RefreshModel();
        //this
        //   .ObserveEveryValueChanged(self => self._avaterModel)
        //   .Skip(1) // 初回は無視
        //   .Subscribe(OnModelChanged)
        //   .AddTo(gameObject);
#if UNITY_EDITOR || UNITY_EDITOR_OSX
        SetGLB(null);
#endif

    }
    /// <summary>
    /// 選択中のモデルが変化したときに呼び出すコールバック関数
    /// </summary>
    /// <param name="o"></param>
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


    /// <summary>
    /// Importerの初期化
    /// </summary>
    private void InitGltfImport()
    {
        _settings = new ImportSettings { };
        //if (_gltfImport != null) return;
        _gltfImport = new GltfImport(
            materialGenerator: new CustomMaterialGenerator(mat_vertexColorApply));
        //_gltfImport.defaultMaterial = mat_vertexColorApply;
        
    }

    private void ClearModel()
    {
        foreach(var child in GetComponentsInChildren<Transform>())
        {
            //名前がworldの子オブジェクトを削除する。
            if (child.name == "world")
                Destroy(child.gameObject);
        }
    }
    /// <summary>
    /// urlで指定されたGLBモデルをインポート
    /// </summary>
    /// <param name="url">GLBのURL null指定時はModelUrlに初期設定されたUrlからGLBを読み込む</param>
    public async void SetGLB(string url)
    {
        
        if(ModelUrl == null && url == null)
        {
            Debug.LogWarning("Both parameter \"ModelUrl\" & \"url\" are null and cannot be set GLB!!");
        }
        InitGltfImport();
        ClearModel();

        Debug.Log("onEditor");

        var loadingURL = (url == null) ? ModelUrl : url;
        Debug.Log("loading: " + loadingURL);
        var success = await _gltfImport.Load(loadingURL,_settings);

        if (success)
        {
            success = await _gltfImport.InstantiateMainSceneAsync(transform);
            Debug.Log("setGLB: " + url);
            if (url == null) return;
            //生成したら、モデルのURLを保存
            ModelUrl = url;
        }
        else
        {
            Debug.LogError("GLBを読み込めませんでした。");
            return;
        }

        
       
    }

    class CustomMaterialGenerator : GLTFast.Materials.IMaterialGenerator
    {
        private Material defaultMaterial;

        // コンストラクタでdefaultMaterialを受け取る
        public CustomMaterialGenerator(Material defaultMaterial)
        {
            this.defaultMaterial = defaultMaterial;
        }

        // IMaterialGeneratorのメソッドを実装
        public Material GenerateMaterial(GLTFast.Schema.MaterialBase gltfMaterial, IGltfReadable gltf, bool pointsSupport)
        {
            // カスタムのマテリアル生成ロジックを実装
            // gltfMaterialやgltfを使用してカスタマイズが可能

            // ここでは単純にdefaultMaterialを返す例
            return defaultMaterial;
        }

        public Material GetDefaultMaterial(bool pointsSupport)
        {
            // カスタムのデフォルトマテリアル生成ロジックを実装

            // ここでは単純にdefaultMaterialを返す例
            return defaultMaterial;
        }

        public void SetLogger(ICodeLogger logger)
        {
            // ロガーを設定するロジックを実装
        }
    }


}
