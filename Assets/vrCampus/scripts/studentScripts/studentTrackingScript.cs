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

    string joystickName;
    bool isTPTouched;
    bool isTPPressed;
    float trigger;
    float tpHorizontal;
    float tpVertical;

    const string TPTOUCHED = "TPTouched";
    const string TPPRESSED = "TPPressed";
    const string TRIGGER = "Trigger";
    const string TPHORIZONTAL = "TPHorizontal";
    const string TPVERTICAL = "TPVertical";

    string debugInfo;

    // Once you complete this module, we'll keep your Update function active
    // to drive the map display
    void Update () {
        debugInfo = "";
        GetNodeStates();
        headsetUpdate();
        controllerUpdate();
        updateControllerInfo();
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
        trackingScreen.ControllerInfo(
            joystickName, 
            isTPTouched, 
            isTPPressed, 
            trigger, 
            tpHorizontal, 
            tpVertical
        );
        trackingScreen.DebugInfo(debugInfo);
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

    void updateControllerInfo()
    {
        if(Input.GetJoystickNames().Length > 0)
            joystickName = Input.GetJoystickNames()[0];
        isTPTouched = Input.GetButton(TPTOUCHED);
        isTPPressed = Input.GetButton(TPPRESSED);
        trigger = Input.GetAxis(TRIGGER);
        tpHorizontal = Input.GetAxis(TPHORIZONTAL);
        tpVertical = Input.GetAxis(TPVERTICAL);

        // debugInfo += "\n" + joystickName;
        debugInfo += "\n touched:" + isTPTouched.ToString();
        debugInfo += "\n pressed:" + isTPPressed.ToString();
        debugInfo += "\n trigger:" + trigger.ToString();
        debugInfo += "\n horizontal:" + tpHorizontal.ToString();
        debugInfo += "\n vertical:" + tpVertical.ToString();
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
                    debugInfo += "\n" + nodeState.nodeType.ToString();
                    return;
                }

            }
        }
    }
}
