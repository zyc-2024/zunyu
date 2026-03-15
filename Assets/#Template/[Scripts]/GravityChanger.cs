using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GravityChanger : MonoBehaviour
{
    public Vector3 newGravity = new Vector3(0, -9.81f, 0);
    void onTriggerEnter(Collider other)
    {
        Physics.gravity = newGravity;
    }
}
