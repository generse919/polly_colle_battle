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




#if UNITY_EDITOR
[ExecuteInEditMode]
#endif
public class ModelGenerator : MonoBehaviour
{
    [SerializeField]
    GameObject _avaterModel;

    [SerializeField]
    UnityEngine.Material mat_vertexColorApply;

    [SerializeField]
    String ModelUrl = null;

    GameObject _avaterInstance;

    GltfImport _gltfImport;
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
        _gltfImport = new GltfImport(
            materialGenerator: new CustomMaterialGenerator(mat_vertexColorApply));
        //_gltfImport.defaultMaterial = mat_vertexColorApply;
        _settings = new ImportSettings{ };
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

    public async void SetGLB(string url)
    {
        if (ModelUrl == url) return;
        InitGltfImport();
        ClearModel();

        var success = await _gltfImport.Load(url,_settings);

        if (success)
        {
            success = await _gltfImport.InstantiateMainSceneAsync(transform);
        }
        else
        {
            Debug.LogError("GLBを読み込めませんでした。");
        }

        if (!success)
        {
            Debug.LogError("GLBのインスタンス化に失敗しました。");
        }

        //生成したら、モデルのURLを保存
        ModelUrl = url;
       
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
