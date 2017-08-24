Date: Thu, 24 Aug 2017 11:01:55 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/4] constify rtc i2c_device_id
Message-ID: <20170824090155.vka35qu6jv3aw63h@piout.net>
References: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503169678-18078-1-git-send-email-arvind.yadav.cs@gmail.com>
List-ID: <linux-rtc.vger.kernel.org>

On 20/08/2017 at 00:37:54 +0530, Arvind Yadav wrote:
> i2c_device_id are not supposed to change at runtime. All functions
> working with i2c_device_id provided by <linux/i2c.h> work with
> const i2c_device_id. So mark the non-const structs as const.
> 
> Arvind Yadav (4):
>   [PATCH 1/4] rtc: ds1672: constify i2c_device_id
>   [PATCH 2/4] rtc: em3027: constify i2c_device_id
>   [PATCH 3/4] rtc: max6900: constify i2c_device_id
>   [PATCH 4/4] rtc: rv3029c2: constify i2c_device_id
> 
>  drivers/rtc/rtc-ds1672.c   | 2 +-
>  drivers/rtc/rtc-em3027.c   | 2 +-
>  drivers/rtc/rtc-max6900.c  | 2 +-
>  drivers/rtc/rtc-rv3029c2.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 

All applied.

> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
