Return-Path: <rtc-linux+bncBC2IF264UIPRBBUMRPCQKGQE35V56HA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id h62si175415wme.2.2017.02.14.00.55.33
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 00:55:33 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH v2 3/4] rtc: cros-ec: add cros-ec-rtc driver.
To: Lee Jones <lee.jones@linaro.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170119123032.24679-1-enric.balletbo@collabora.com>
 <20170119123032.24679-3-enric.balletbo@collabora.com>
 <20170122233232.iin6frv7hme2y2jw@piout.net> <20170123121438.GM16020@dell>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
 Olof Johansson <olof@lixom.net>, Alessandro Zummo <a.zummo@towertech.it>,
 Stephen Barber <smbarber@chromium.org>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c492877b-5bd1-511a-7591-b4ff911ceabc@collabora.com>
Date: Tue, 14 Feb 2017 09:55:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121438.GM16020@dell>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Lee,

On 23/01/17 13:14, Lee Jones wrote:
> On Mon, 23 Jan 2017, Alexandre Belloni wrote:
> 
>> On 19/01/2017 at 13:30:31 +0100, Enric Balletbo i Serra wrote :
>>> From: Stephen Barber <smbarber@chromium.org>
>>>
>>> On platforms with a Chrome OS EC, the EC can function as a simple RTC.
>>> Add a basic driver with this functionality.
>>>
>>> Signed-off-by: Stephen Barber <smbarber@chromium.org>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>
>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>>
>> Lee, this can go through the mfd tree. Hopefully, nobody will add a new
>> driver nearby ;)
> 
> Yes, I can take the set, once all of the Acks are obtained.
> 

Now that the patch series have all the acks, this will finally go through the mfd tree?

I suppose is too late for the upcoming merge window ... so just want to make sure which tree I should monitor to not forget it :)

Thanks,
 Enric



-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
