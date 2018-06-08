using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Controller : MonoBehaviour {
    private SteamVR_TrackedObject trackedobj;

    private SteamVR_Controller.Device controller
    {
        get { return SteamVR_Controller.Input((int)trackedobj.index); }
    }

    private void Awake()
    {
        trackedobj = GetComponent<SteamVR_TrackedObject>();
    }

    private void Update()
    {
        if(controller.GetHairTrigger())
        {
            
        }
    }
}
