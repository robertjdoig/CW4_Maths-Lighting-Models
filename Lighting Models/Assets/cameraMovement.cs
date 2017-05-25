using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class cameraMovement : MonoBehaviour {

    [SerializeField]
    private int totalNumberofCars;

    [SerializeField]
    private float moveSpeedX = 10;

    [SerializeField]
    private float moveSpeedZ = 1;


	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
     
        float movementX = Input.GetAxis("Horizontal") * moveSpeedX;
        float movementZ = Input.GetAxis("Vertical") * moveSpeedZ;

        transform.Translate(movementX,0,movementZ);
        
            
	}
}
