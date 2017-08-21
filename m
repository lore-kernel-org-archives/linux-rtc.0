Return-Path: <rtc-linux+bncBD3M5JPEVAFRBS475PGAKGQEWLQSLEI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (mail-by2nam03on0046.outbound.protection.outlook.com. [104.47.42.46])
        by gmr-mx.google.com with ESMTPS id p68si1806023pfp.10.2017.08.21.05.19.23
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 05:19:23 -0700 (PDT)
Subject: Re: [rtc-linux] RTC used as a module
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Michal Simek
	<monstr@monstr.eu>
CC: Michal Simek <michal.simek@xilinx.com>, John Stultz
	<john.stultz@linaro.org>, "rtc-linux@googlegroups.com"
	<rtc-linux@googlegroups.com>
References: <20170223121426.i24ssrlwitrvb32h@piout.net>
 <232e7023-4571-3a91-2366-753a1479c52a@monstr.eu>
 <6e9bb8fa-52e5-0a3a-38b7-57c34bcdfb6b@monstr.eu>
 <CALAqxLUWD23LWh3z8sr_hFMvrf+SmVOH-i6VHDr60uQZRyWXbA@mail.gmail.com>
 <cd325ab6-b31c-a03f-2bd3-e2e8cb99a6a5@xilinx.com>
 <8f181912-d6b1-fe2b-92ef-df2cb26f3f02@xilinx.com>
 <cc3a8f33-1d68-2ad1-6aba-773f53c29d61@xilinx.com>
 <59e7661e-7e1f-a11e-93c2-9a4bbe9ebe1a@xilinx.com>
 <20170820220329.uzx3ryehq75qruwz@piout.net>
 <44ce48f1-73bb-1b88-1e92-327e80f09f96@monstr.eu>
 <20170821121344.emzboqji3hhakzpf@piout.net>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <ac7f1a06-a20a-3fe8-8ef1-01423d742836@xilinx.com>
Date: Mon, 21 Aug 2017 14:19:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170821121344.emzboqji3hhakzpf@piout.net>
Content-Type: text/plain; charset="UTF-8"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21.8.2017 14:13, Alexandre Belloni wrote:
> On 21/08/2017 at 12:50:34 +0200, Michal Simek wrote:
>> Hi,
>>
>> On 21.8.2017 00:03, Alexandre Belloni wrote:
>>> Hi Michal,
>>>
>>> I've just send a patch to fix this issue (and avoid your other patch).
>>>
>>> Could you test it? (I did test on an atmel platform)
>>>
>>> Sorry it took so long!
>>
>> not a problem but it looks like it is still just temporary solution. I
>> would expect that you can't unload module when this alarm is used. It if
>> it is not used then you should be able to remove it.
>>
> 
> Yes, the alarmtimer handling needs to be made more flexible, especially
> in the rtc device selection.

ok. What about to extend that commit message for the patch you sent to
explicitly say that this is temporary solution and what should be the
right fix?

Maybe you can also add link that patch which introduced this issue.
It was in that patch I sent.

Thanks,
Michal



-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
