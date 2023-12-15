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
    String ModelUrl;

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

    //public IObservable<UnityEngine.Object> LoadFBX(string fbxFilePath)
    //{
    //    // FBXファイルのパスが指定されているか確認
    //    if (string.IsNullOrEmpty(fbxFilePath))
    //    {
    //        Debug.LogError("FBXファイルのパスが指定されていません。");
    //        return Observable.Throw<UnityEngine.Object>(new ArgumentNullException("fbxFilePath"));
    //    }

    //    // ファイルが存在するか確認
    //    if (!File.Exists(fbxFilePath))
    //    {
    //        return Observable.Throw<UnityEngine.Object>(new FileNotFoundException("指定されたFBXファイルが見つかりません", fbxFilePath));
    //    }

    //    return Observable.FromCoroutine<UnityEngine.Object>(observer => LoadFBXCoroutine(observer, fbxFilePath));
    //}

    //private IEnumerator LoadFBXCoroutine(IObserver<UnityEngine.Object> observer, string fbxFilePath)
    //{
    //    using (UnityWebRequest request = UnityWebRequest.Get("file://" + fbxFilePath))
    //    {
    //        yield return request.SendWebRequest();

    //        if (request.result == UnityWebRequest.Result.Success)
    //        {
    //            // PLYデータを読み込む
    //            Mesh mesh = LoadPLYData(request.downloadHandler.text);

    //            if (mesh != null)
    //            {
    //                observer.OnNext(mesh) ;
    //                observer.OnCompleted();
    //            }
    //            else
    //            {
    //                observer.OnError(new Exception("PLYデータの読み込みエラー"));
    //            }
    //        }
    //        else
    //        {
    //            observer.OnError(new Exception("FBXファイルの読み込みエラー: " + request.error));
    //        }
    //    }
    //}

//    public void SetFBX(string path) {
//        //LoadFBX(path)
//        //        .Subscribe(
//        //        fbxObject => {
//        //            GameObject instantiatedObject = (GameObject)Instantiate(fbxObject);
//        //            // Additional logic for handling the loaded object
//        //            if(instantiatedObject != null)
//        //            {
//        //                _avaterInstance = instantiatedObject;
//        //            }
//        //            else
//        //            {
//        //                Debug.LogError("ファイルの読み込みに失敗しました");
//        //            }
//        //        },
//        //    error => Debug.LogError("エラー: " + error),
//        //    () => Debug.Log("処理が完了しました。")
//        //);
//        LoadFBX(path);
//    }

//    void LoadFBX(string filePath)
//    {

//        AssimpContext importer = new AssimpContext();

//#if UNITY_ANDROID
//        var loadingRequest = UnityWebRequest.Get(Path.Combine(Application.streamingAssetsPath, "Model.fbx"));
//        loadingRequest.SendWebRequest();

//        while (!loadingRequest.isDone)
//        {
//            if (loadingRequest.result == UnityWebRequest.Result.ConnectionError || loadingRequest.result == UnityWebRequest.Result.ProtocolError)
//            {
//                break;
//            }
//        }

//        if (loadingRequest.result == UnityWebRequest.Result.ConnectionError || loadingRequest.result == UnityWebRequest.Result.ProtocolError)
//        {
//            return;
//        }

//        MemoryStream fileStream = new MemoryStream(loadingRequest.downloadHandler.data);
//#else
//        var fileStream = File.OpenRead(filePath);
//#endif

//        // FBXをロード
//        Scene scene = importer.ImportFile(filePath, PostProcessSteps.Triangulate | PostProcessSteps.FlipUVs);

//        if (scene != null && scene.HasMeshes)
//        {
//            // 最初のメッシュを取得
//            UnityEngine.Mesh unityMesh = CreateMesh(scene.Meshes[0]);

//            // 新しいGameObjectを作成
//            GameObject newObject = new GameObject("FBXObject");

//            //// MeshRendererを追加してMeshを割り当てる
//            MeshRenderer meshRenderer = newObject.AddComponent<MeshRenderer>();
//            //meshRenderer.sharedMaterial = new Material(Shader.Find("Standard"));

//            //// MeshFilterを追加してMeshを割り当てる
//            MeshFilter meshFilter = newObject.AddComponent<MeshFilter>();
//            meshFilter.mesh = unityMesh;

//            // この新しいGameObjectを使って何かを行う (例: 位置の調整など)
//            OnModelChanged(newObject);

//        }
//        else
//        {
//            Debug.LogError("FBXファイルの読み込みに失敗しました。");
//        }
//    }


    //UnityEngine.Mesh CreateMesh(Assimp.Mesh assimpMesh)
    //{
    //    // AssimpのMeshからUnityのMeshに変換する処理を実装
    //    // この例では省略
    //    // 必要に応じて、頂点座標、法線、UV、三角形インデックスなどを設定



    //    var unityMesh = new UnityEngine.Mesh();
    //    List<Vector3> vertices = new(assimpMesh.Vertices.Count);
    //    foreach (Vector3D vertex in assimpMesh.Vertices)
    //    {
    //        vertices.Add(new Vector3(vertex.X, vertex.Y, vertex.Z));
    //    }
    //    unityMesh.vertices = vertices.ToArray();

    //    List<int> triangles = new();
    //    foreach (Assimp.Face face in assimpMesh.Faces)
    //    {
    //        face.Indices.Reverse();
    //        triangles.AddRange(face.Indices);
    //    }
    //    unityMesh.triangles = triangles.ToArray();

    //    List<Vector3> normals = new(assimpMesh.Normals.Count);
    //    foreach (Vector3D vertex in assimpMesh.Normals)
    //    {
    //        normals.Add(new Vector3(vertex.X, vertex.Y, vertex.Z));
    //    }
    //    unityMesh.normals = normals.ToArray();

    //    List<Vector4> tangents = new(assimpMesh.Tangents.Count);
    //    foreach (Vector3D tangent in assimpMesh.Tangents)
    //    {
    //        tangents.Add(new Vector4(tangent.X, tangent.Y, tangent.Z, 1));
    //    }
    //    unityMesh.tangents = tangents.ToArray();

    //    if (assimpMesh.HasTextureCoords(0))
    //    {
    //        List<Vector2> uv = new();
    //        foreach (Assimp.Vector3D tan in assimpMesh.TextureCoordinateChannels[0])
    //        {
    //            uv.Add(new Vector2(tan.X, tan.Y));
    //        }
    //        unityMesh.uv = uv.ToArray();
    //    }

    //    unityMesh.RecalculateBounds();

    //    //var meshFilter = Instantiate(MeshTemplate, new Vector3(0, 0, 0), UnityEngine.Quaternion.identity);
    //    return unityMesh;
    //}

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
