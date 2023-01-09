﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;
using UnityEngine.XR.ARSubsystems;

[RequireComponent(typeof(ARRaycastManager))]
public class ARTapToPlace : MonoBehaviour
{

    public GameObject WorldToSpawn;

    private GameObject SpawnedWorld;
    private ARRaycastManager _arRaycastmanager;
    private Vector2 touchPosition;

    static List<ARRaycastHit> hits = new List<ARRaycastHit>();


    private void Awake()
      {
        _arRaycastmanager = GetComponent<ARRaycastManager>();

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

            if(SpawnedWorld == null) 
            { 
                SpawnedWorld = Instantiate(WorldToSpawn, hitPose.position,hitPose.rotation);
            }
            else
            {
                SpawnedWorld.transform.position = hitPose.position;
            }
        }
    }
}
