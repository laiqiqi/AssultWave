using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Blink : MonoBehaviour
{
    private SteamVR_TrackedObject TrackedObj;
    private SteamVR_Controller.Device controller
    {
        get { return SteamVR_Controller.Input((int)TrackedObj.index); }
    }
    
    
    
}
