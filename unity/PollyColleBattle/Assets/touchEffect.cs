using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class touchEffect : MonoBehaviour
{
    [SerializeField]
    ParticleSystem particle;
    public float depth = 10.0f; // depth from the camera

    // Update is called once per frame
    void Update()
    {
         if (Input.GetMouseButtonDown(0))
        {
            Vector2 touchPosition = Input.mousePosition;

            // Convert the 2D screen position into a 3D world position
            Vector3 worldPosition = Camera.main.ScreenToWorldPoint(new Vector3(touchPosition.x, touchPosition.y, depth));

            // Instantiate the effect at the touch position and play it
            ParticleSystem effect = Instantiate(particle, worldPosition, Quaternion.identity);
            effect.Play();

            // Optional: Destroy the effect after it has finished playing
            Destroy(effect.gameObject, effect.main.duration);
        }
    }


}
