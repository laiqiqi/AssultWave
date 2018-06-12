using System.Collections;
using System.Collections.Generic;
using System.Security;
using UnityEngine;

public enum MoveType { BLINK, MOVE }

public class PlayerManager : MonoBehaviour
{
    public static Transform PlayerTransform
    {
        get { return instance.Tr; }
    }

    public static PlayerManager instance;
    
    [SerializeField] private MoveType moveType = MoveType.BLINK;
    private Blink Move_Blink;
    private Walk Move_Walk;

    private Transform Tr;


    private void Start()
    {
        Tr = GetComponent<Transform>();
        Move_Blink = GetComponent<Blink>();
        Move_Walk = GetComponent<Walk>();

        instance = this;
    }

    private void Update()
    {
        switch (moveType)
        {
            case MoveType.BLINK:
                break;
            case MoveType.MOVE:
                
                break;
        }
    }
}
