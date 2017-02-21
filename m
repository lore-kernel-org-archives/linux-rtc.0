Return-Path: <rtc-linux+bncBDKOZ45RYIGRBCPGWHCQKGQECHCVEAA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (mail-co1nam03on0134.outbound.protection.outlook.com. [104.47.40.134])
        by gmr-mx.google.com with ESMTPS id f7si3111694pfk.5.2017.02.21.09.04.09
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Feb 2017 09:04:09 -0800 (PST)
From: Hartley Sweeten <HartleyS@visionengravers.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"alex@digriz.org.uk" <alex@digriz.org.uk>, Alessandro Zummo
	<a.zummo@towertech.it>
Subject: [rtc-linux] RE: [PATCH 1/5] rtc: m48t86: verify that the RTC is
 actually present
Date: Tue, 21 Feb 2017 17:04:07 +0000
Message-ID: <SN1PR0101MB15652C26018F5BE5369DE4C7D0510@SN1PR0101MB1565.prod.exchangelabs.com>
References: <20170215163527.5697-1-hsweeten@visionengravers.com>
 <20170215163527.5697-2-hsweeten@visionengravers.com>
 <20170221163720.m6hp27t4z7q4pgwl@piout.net>
In-Reply-To: <20170221163720.m6hp27t4z7q4pgwl@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tuesday, February 21, 2017 9:37 AM, Alexandre Belloni wrote:
> On 15/02/2017 at 09:35:23 -0700, H Hartley Sweeten wrote:
>> The RTC is an optional feature at purchase time on some Technologic
>> Systems boards. Verify that it actually exists by checking if the
>> last two bytes of the NVRAM can be changed.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: Alexander Clouter <alex@digriz.org.uk>
>> ---
>>  drivers/rtc/rtc-m48t86.c | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>> 
>
> I've applied that one. Alex, if you are fine with the mach-orion5x
> changes, I can take them for 4.11. Else, this will wait for 4.12.

Hello,

Thanks. The change to mach-ep93xx is ok if you want to take that one.

I did just notice a minor issue with this one. It will still work as-is but
It's not technically doing what was done in mach-orion52. See below...

>> diff --git a/drivers/rtc/rtc-m48t86.c b/drivers/rtc/rtc-m48t86.c
>> index 4dc4af4..41ac5d6 100644
>> --- a/drivers/rtc/rtc-m48t86.c
>> +++ b/drivers/rtc/rtc-m48t86.c
>> @@ -201,6 +201,37 @@ static ssize_t m48t86_nvram_write(struct file *filp, struct kobject *kobj,
>>  static BIN_ATTR(nvram, 0644, m48t86_nvram_read, m48t86_nvram_write,
>>  		M48T86_NVRAM_LEN);
>>  
>> +/*
>> + * The RTC is an optional feature at purchase time on some Technologic Systems
>> + * boards. Verify that it actually exists by checking if the last two bytes
>> + * of the NVRAM can be changed.
>> + *
>> + * This is based on the method used in their rtc7800.c example.
>> + */
>> +static bool m48t86_verify_chip(struct platform_device *pdev)
>> +{
>> +	unsigned int offset0 = M48T86_NVRAM_LEN - 2;
>> +	unsigned int offset1 = M48T86_NVRAM_LEN - 1;

In order to address the last two bytes, these two offsets should actually be:

+	unsigned int offset0 = M48T86_NVRAM(M48T86_NVRAM_LEN - 2);
+	unsigned int offset1 = M48T86_NVRAM(M48T86_NVRAM_LEN - 1);

As they are right now, they are both off by 14 bytes (0x0e).

I can send a patch to fix it or you can do it if you prefer.

Sorry about that.
Hartley

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
