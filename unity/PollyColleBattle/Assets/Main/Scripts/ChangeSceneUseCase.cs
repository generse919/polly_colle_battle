
using UnityEngine;
using Zenject;
using Domain.Entity;
using UniRx;
using UnityEngine.SceneManagement;

namespace Domain.UseCase
{
    public class ChangeSceneUseCase : IInitializable, IChangeSceneUseCase
    {
        [Inject] private ISceneEntity sceneEntity;

        void IInitializable.Initialize()
        {
            sceneEntity
                .SceneRP
                .SkipLatestValueOnSubscribe() //初期値のプッシュを無視する
                .Subscribe(scene => LoadScene(scene.ToString()));
        }

        public void LoadScene(string sceneName)
        {
            SceneManager.LoadScene(sceneName);
        }
    }

    public interface IChangeSceneUseCase
    {

    }
}

