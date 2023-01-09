using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

[RequireComponent(typeof(ARRaycastManager))]
public class ARTapToPlace : MonoBehaviour
{

    public GameObject BigWorldToSpawn;
    public GameObject SmallWorldToSpawn;

    private GameObject SpawnedWorld;
    private ARRaycastManager _arRaycastmanager;
    private Vector2 touchPosition;

    static List<ARRaycastHit> hits = new List<ARRaycastHit>();

    bool Isbig;

    private void Awake()
      {
        _arRaycastmanager = GetComponent<ARRaycastManager>();

    }

    public void SetSizeBig()
    {
        Isbig = true;

    }
    public void SetSizeSmall()
    {
        Isbig = false;

    }
    bool TryGetTouchPosition(out Vector2 touchPosition)
    {
        if (Input.touchCount > 0)
        {
            touchPosition = Input.GetTouch(0).position;
            return true;
        }
        touchPosition = default; 
        return false;
    }

    void Update()
    {
        if(!TryGetTouchPosition(out Vector2 touchposition)) 
             return;

        if (_arRaycastmanager.Raycast(touchposition, hits, TrackableType.PlaneWithinPolygon))
        {
            var hitPose = hits[0].pose;

            if(SpawnedWorld == null && Isbig == true ) 
            { 
                SpawnedWorld = Instantiate(BigWorldToSpawn, hitPose.position,hitPose.rotation);
            }
            else
            {
                if (Isbig == false && SpawnedWorld == null)
                {
                    SpawnedWorld = Instantiate(SmallWorldToSpawn, hitPose.position, hitPose.rotation);
                 
                }

                SpawnedWorld.transform.position = hitPose.position;
             
            }
        }
    }
}
