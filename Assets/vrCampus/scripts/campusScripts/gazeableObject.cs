using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using vrCampusCourseware;

public class gazeableObject : MonoBehaviour {
    public event Action OnOver;             // Called when the gaze moves over this object
    public event Action OnOut;              // Called when the gaze leaves this object

    protected bool m_IsOver;

    public bool IsOver
    {
        get { return m_IsOver; }              // Is the gaze currently over this object?
    }

    public void Over()
    {
        m_IsOver = true;

        if (OnOver != null)
            OnOver();
    }


    public void Out()
    {
        m_IsOver = false;

        if (OnOut != null)
            OnOut();
    }
}
