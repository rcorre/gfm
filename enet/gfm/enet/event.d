module gfm.enet.event;

import derelict.enet.enet;

import gfm.enet.enet,
       gfm.enet.packet,
       gfm.enet.peer;

final class Event
{
    private
    {
        ENetEvent *_handle;
        Peer _peer;
        Packet _packet;
    }

    public
    {
        /// Possible types of an event.
        enum Type
        {
            none = ENET_EVENT_TYPE_NONE,
            connect = ENET_EVENT_TYPE_CONNECT,
            disconnect = ENET_EVENT_TYPE_DISCONNECT,
            receive = ENET_EVENT_TYPE_RECEIVE
        }

        this(ENet enet, ENetEvent *handle)
        {
            _handle = handle;
            _peer = new Peer(enet, _handle.peer);
            if(_handle.type == ENET_EVENT_TYPE_RECEIVE)
                _packet = new Packet(enet, _handle.packet);
            else
                _packet = null;
        }

        /// Trivial getters for _ENetEvent struct.
        @property
        {
            Type type() 
            { 
                return cast(Type)_handle.type; 
            }

            Peer peer() 
            { 
                return _peer; 
            }

            ubyte channelID() 
            { 
                return _handle.channelID; 
            }

            uint data() 
            { 
                return _handle.data; 
            }

            Packet packet() 
            { 
                return _packet; 
            }
        }
    }
}
