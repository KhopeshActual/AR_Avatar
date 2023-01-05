using System;
using UnityEngine;
using TMPro;

public class AvatarsController : MonoBehaviour
{
    [Serializable]
    private class AnimationsList
    {
        public string[] _animations;
    }
    
    [Header("AVATARS")]
    [SerializeField] private GameObject[] _avatars;
    
    [Header("ANIMATIONS")]
    [SerializeField] private AnimationsList[] _animations;

    [Header("AUDIO")]
    [SerializeField] private AudioSource _haloAudio;
    [SerializeField] private AudioSource _destinyAudio;

    [Header("UI")]
    public TMP_Dropdown _animationsDropdown;
    public TMP_Dropdown _avatarsDropdown;
    
    [Header("CONFIGURATIONS")]
    [SerializeField] private int _defaultId;


    private int _currentAvatarId;
    private bool _isAudioMuted = false;

    public void Start()
    {
        SetAvatarDropdown();
        SetAnimDropdown(_defaultId);

        SelectAvatar(_defaultId);
    }

    public void ToggleAudio()
    {
        if (!_isAudioMuted)
        {
            _haloAudio.volume = 0;
            _destinyAudio.volume = 0;
        }
        else
        {
            _haloAudio.volume = 0.5f;
            _destinyAudio.volume = 0.5f;
        }
        
        _isAudioMuted = !_isAudioMuted;
    }

    public void SelectAvatar(int id)
    {
        _avatarsDropdown.value = _currentAvatarId = id;
        
        for (var i = 0; i < _avatars.Length; i++)
        {
            _avatars[i].SetActive(i == _currentAvatarId);
        }

        SelectAnimation(id, default);
    }
    
    public void SelectAnimation(int avatarId, int animationId)
    {
        var trigger = string.Empty;
        
        try
        {
            trigger = _animations[_currentAvatarId]._animations[animationId];
        }
        catch
        {
            Debug.LogError("Animation list is incomplete");
        }
        
        _avatars[_currentAvatarId].GetComponent<Animator>().SetTrigger(trigger);
    }

    private void SetAnimDropdown(int selectedAvatarId)
    {
        _animationsDropdown.options.Clear();

        var set = _animations[selectedAvatarId]._animations;
        
        foreach (var anim in set)
        {
            _animationsDropdown.options.Add(new TMP_Dropdown.OptionData(anim));
        }
        
        _animationsDropdown.value = default;
    }
    
    private void SetAvatarDropdown()
    {
        _avatarsDropdown.options.Clear();

        for (var i = 0; i < _avatars.Length; i++)
        {
            _avatarsDropdown.options.Add(new TMP_Dropdown.OptionData("Avatar " + i));
        }
    }
}
