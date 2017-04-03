Return-Path: <rtc-linux+bncBC2IF264UIPRBUOMRHDQKGQEFVFUYHQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk. [2a00:1098:0:82:1000:25:2eeb:e3e3])
        by gmr-mx.google.com with ESMTPS id t131si859014wmf.1.2017.04.03.08.12.17
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 08:12:17 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH 1/7] mfd: cros-ec: Fix host command buffer size
To: Lee Jones <lee.jones@linaro.org>
References: <20170324174407.25401-1-enric.balletbo@collabora.com>
 <20170324174407.25401-2-enric.balletbo@collabora.com>
 <20170403142357.2usczfylqbg6cgcx@dell> <20170403143020.mti5vdig6vvlcb2d@dell>
Cc: Jonathan Cameron <jic23@kernel.org>, Olof Johansson <olof@lixom.net>,
 bleung@chromium.org, martinez.javier@gmail.com,
 Guenter Roeck <groeck@chromium.org>, Gwendal Grignou <gwendal@chromium.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 rtc-linux@googlegroups.com, Vic Yang <victoryang@google.com>
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <78c54848-3166-4531-2178-0fe73b94727a@collabora.com>
Date: Mon, 3 Apr 2017 17:12:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170403143020.mti5vdig6vvlcb2d@dell>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 03/04/17 16:30, Lee Jones wrote:
> On Mon, 03 Apr 2017, Lee Jones wrote:
> 
>> On Fri, 24 Mar 2017, Enric Balletbo i Serra wrote:
>>
>>> From: Vic Yang <victoryang@google.com>
>>>
>>> For SPI, we can get up to 32 additional bytes for response preamble.
>>> The current overhead (2 bytes) may cause problems when we try to receive
>>> a big response. Update it to 32 bytes.
>>>
>>> Without this fix we could see a kernel BUG when we receive a big response
>>> from the Chrome EC when is connected via SPI.
>>>
>>> Signed-off-by: Vic Yang <victoryang@google.com>
>>> Tested-by: Enric Balletbo i Serra <enric.balletbo.collabora.com>
>>> ---
>>>
>>>   This patch is a FIX, and I think that would be interesting see it merged
>>> in this release cycle. This should go through the MFD tree and can be picked
>>> independently of the other patches. Lee Jones I think this is for you.
>>>
>>>  include/linux/mfd/cros_ec.h | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> Applied, thanks.
> 
> Scrap that, I'll keep it with the set.
> 

Ok, I'll send a v2 asap with this patch and the few modifications requested on
patch 7/7. I'm wondering though if this specific patch could go with current
release cycle as (explained above) is a fix and current kernel is affected.

Thanks,
 Enric

>>> diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
>>> index b3e812f..3b16c90 100644
>>> --- a/include/linux/mfd/cros_ec.h
>>> +++ b/include/linux/mfd/cros_ec.h
>>> @@ -35,10 +35,11 @@
>>>   * Max bus-specific overhead incurred by request/responses.
>>>   * I2C requires 1 additional byte for requests.
>>>   * I2C requires 2 additional bytes for responses.
>>> + * SPI requires up to 32 additional bytes for responses.
>>>   * */
>>>  #define EC_PROTO_VERSION_UNKNOWN	0
>>>  #define EC_MAX_REQUEST_OVERHEAD		1
>>> -#define EC_MAX_RESPONSE_OVERHEAD	2
>>> +#define EC_MAX_RESPONSE_OVERHEAD	32
>>>  
>>>  /*
>>>   * Command interface between EC and AP, for LPC, I2C and SPI interfaces.
>>
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
