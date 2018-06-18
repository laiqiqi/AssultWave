using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Walk : MonoBehaviour {
    
    private SteamVR_TrackedObject TrackedObj;
    private SteamVR_Controller.Device controller
    {
        get { return SteamVR_Controller.Input((int)TrackedObj.index); }
    }

    [SerializeField] private float MoveSpeed = 14f;
    
    private Vector2 PadInput;

    private void Awake()
    {
        TrackedObj=GetComponent<SteamVR_TrackedObject>();
    }

    private void Update()
    {
        PadInput = controller.GetAxis();

        Vector3 moveDir = new Vector3(PadInput.x, 0, PadInput.y);

        if (moveDir != Vector3.zero)
            PlayerManager.PlayerTransform.Translate(moveDir.normalized * MoveSpeed * Time.deltaTime);
        
    }
}
