Date: Wed, 12 Oct 2016 13:28:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Oleksij Rempel <linux@rempel-privat.de>
Subject: Re: [rtc-linux] [PATCH v3 0/3] add device tree support for rtc-rv8803
Message-ID: <20161012112827.mrvledaqmh3dwg2s@piout.net>
References: <1467211201-17252-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467211201-17252-1-git-send-email-dirk.behme@de.bosch.com>
List-ID: <rtc-linux.googlegroups.com>

Hi,

On 29/06/2016 at 16:39:58 +0200, Dirk Behme wrote :
> From: Oleksij Rempel <linux@rempel-privat.de>
> 
> Changes v2:
> - rename mc to microcrystal
> - rename vdetoff to vdet-disable
> 
> Changes v3:
> - remove of_device_id patch
> - use device type instead of of_device_is_compatible
> 
> Oleksij Rempel (3):
>   devicetree: Add Micro Crystal AG vendor id
>   dt/bindings: Add bindings for Micro Crystal rv8803
>   rtc: rv8803: Be able to set VDETOFF and SWOFF via devcie tree
> 
>  .../devicetree/bindings/rtc/epson,rx8900.txt       | 22 ++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  drivers/rtc/rtc-rv8803.c                           | 50 +++++++++++++++++++++-
>  3 files changed, 71 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8900.txt
> 

I'm applying those patches now because I didn't have to propose anything
better and I don't want to hold off on them too long. But I'm not really
happy with the fact that not putting any property in DT may change the
current configuration.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
