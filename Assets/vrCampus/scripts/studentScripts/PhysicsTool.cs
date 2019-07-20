using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using vrCampusCourseware;

namespace VRCampus
{
    public class PhysicsTool : MonoBehaviour
    {
        public event Action OnHit;
        private void OnTriggerEnter(Collider other)
        {
            if (other.tag != "firebutton") return;
            if (OnHit != null) OnHit();
        }
    }
}
