using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR;
using UnityEngine.UI;
using vrCampusCourseware;
using System;

public class studentTrackingScript : MonoBehaviour {

    [Header("Courseware")]
    [SerializeField]
    TrackingDisplay trackingScreen;

    List<XRNodeState> nodeStates = new List<XRNodeState>();
    Vector3 headsetPos;
    Quaternion headsetRot;
    Vector3 controllerPos;
    Quaternion controllerRot;
    bool hasController;

    // Once you complete this module, we'll keep your Update function active
    // to drive the map display
    void Update () {
        GetNodeStates();
        headsetUpdate();
        controllerUpdate();
        trackingScreen.TrackingInfo(
            XRDevice.model, 
            XRDevice.GetTrackingSpaceType(), 
            headsetPos, 
            headsetRot, 
            hasController, 
            controllerPos, 
            controllerRot, 
            CalculateFPS(), 
            XRSettings.renderViewportScale
        );
    }

    private void Awake()
    {
        InputTracking.nodeAdded += HandleNodeAdded;
        InputTracking.nodeRemoved += HandleNodeRemoved;
        InputTracking.trackingAcquired += HandleTrackingAcquired;
        InputTracking.trackingLost += HandleTrackingLost;
    }

    private void HandleTrackingLost(XRNodeState obj)
    {
        trackingScreen.TrackingEvent(TrackingDisplay.TrackingEventType.trackingLost, obj);
    }

    private void HandleTrackingAcquired(XRNodeState obj)
    {
        trackingScreen.TrackingEvent(TrackingDisplay.TrackingEventType.trackingAcquired, obj);
    }

    private void HandleNodeRemoved(XRNodeState obj)
    {
        trackingScreen.TrackingEvent(TrackingDisplay.TrackingEventType.nodeRemoved, obj);
    }

    private void HandleNodeAdded(XRNodeState obj)
    {
        trackingScreen.TrackingEvent(TrackingDisplay.TrackingEventType.nodeAdded, obj);
    }

    void GetNodeStates()
    {
        InputTracking.GetNodeStates(nodeStates);
    }

    float CalculateFPS()
    {
        return 1.0f / Time.deltaTime;
    }

    void headsetUpdate()
    {
        foreach (XRNodeState nodeState in nodeStates)
        {
            if (nodeState.nodeType == XRNode.Head)
            {
                nodeState.TryGetPosition(out headsetPos);
                nodeState.TryGetRotation(out headsetRot);
                return;
            }
        }
    }

    void controllerUpdate()
    {
        foreach (XRNodeState nodeState in nodeStates)
        {
            if (nodeState.nodeType == XRNode.LeftHand || 
                nodeState.nodeType == XRNode.RightHand || 
                nodeState.nodeType == XRNode.GameController)
            {
                if (nodeState.tracked == true)
                {
                    nodeState.TryGetPosition(out controllerPos);
                    nodeState.TryGetRotation(out controllerRot);
                    hasController = true;
                    trackingScreen.DebugInfo(nodeState.nodeType.ToString());
                    return;
                }

            }
        }
    }
}
