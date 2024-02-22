using UniRx;

namespace Domain.Entity
{
    public class SceneEntity : ISceneEntity
    {
        public IReactiveProperty<Scene> SceneRP { get; }

        public SceneEntity()
        {
            SceneRP = new ReactiveProperty<Scene>(Scene.LoadingScene);
        }

        public void ChangeScene(Scene targetScene)
        {
            SceneRP.Value = targetScene;
        }
    }

    public enum Scene
    {
        LoadingScene,
        PollyScene,
        BattleScene
    }

    public interface ISceneEntity
    {
        IReactiveProperty<Scene> SceneRP { get; }
        void ChangeScene(Scene targetScene);
    }
}
