Return-Path: <rtc-linux+bncBAABBQ6ORXCQKGQEBA4LSJY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail02.prevas.se (mail02.prevas.se. [62.95.78.10])
        by gmr-mx.google.com with ESMTPS id v70si165252wmf.0.2017.02.14.12.23.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 12:23:31 -0800 (PST)
Subject: Re: [rtc-linux] [PATCH] rtc: pcf2127: bulk read only date and time registers.
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <20170201124525.36578-1-sean.nyekjaer@prevas.dk>
 <20170211232135.7bxr4t3pyhdmidh5@piout.net>
Cc: rtc-linux@googlegroups.com
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <8e2684bc-92bb-7f8f-f4e8-248285be4e0b@prevas.dk>
Date: Tue, 14 Feb 2017 21:23:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170211232135.7bxr4t3pyhdmidh5@piout.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,


On 2017-02-12 00:21, Alexandre Belloni wrote:
> Hi,
>
> On 01/02/2017 at 13:45:25 +0100, Sean Nyekjaer wrote:
>> Read control registers one by one and bulk read time registers.
>> This fixes when the clock is read, the watchdog counter register is zeroed.
>>
>> The problem is latent without the watchdog patch
>>
>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>> ---
>> Only tested on pcf2127.
>> I think the pcf2127 have an issue when the register auto-incr is used,
>> when bulk reading the time the watchdog counter is zeroed and stopped.
>>
>>   drivers/rtc/rtc-pcf2127.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-pcf2127.c b/drivers/rtc/rtc-pcf2127.c
>> index 8abc4eb8f289..f54a42b419b5 100644
>> --- a/drivers/rtc/rtc-pcf2127.c
>> +++ b/drivers/rtc/rtc-pcf2127.c
>> @@ -403,9 +403,21 @@ static int pcf2127_rtc_read_time(struct device *dev, struct rtc_time *tm)
>>   	struct pcf2127 *pcf2127 = dev_get_drvdata(dev);
>>   	unsigned char buf[10];
>>   	int ret;
>> +	int i;
>> +
>> +	for (i = 0; i < 3; i++) {
>> +		ret =
>> +		    regmap_read(pcf2127->regmap, PCF2127_REG_CTRL1 + i,
>> +				(unsigned int *)(buf + i));
>> +		if (ret) {
>> +			dev_err(dev, "%s: read error\n", __func__);
>> +			return ret;
>> +		}
>> +	}
>
> CTRL1 and CTRL2 are not used so it is probably enough to only read CTRL3
CTRL1 and CTRL2 is displayed in the dev_dbg just below this in the code.
But not needed in this context.
>
>>   
>> -	ret = regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1, buf,
>> -				sizeof(buf));
>> +	ret =
>> +	    regmap_bulk_read(pcf2127->regmap, PCF2127_REG_CTRL1 + 3, (buf + 3),
>> +			     7);
> This is weirdly indented/wrapped. Also, you can probably make buf a
> char[7] and continue using sizeof() or even better, ARRAY_SIZE()
I'm fixing the indentation for v2 :-)
I agree this is not the prettiest but i actually thinks its best to keep 
the buf[10],
then all the existing defines for registeres will continue to work.
Thats why i did this uglyness.
I could do an timebuf[7], read the time into that and replace the 
register defines,
with array numbers but it will create a lot more diff linies :-S
What do you think ?
>
>>   	if (ret) {
>>   		dev_err(dev, "%s: read error\n", __func__);
>>   		return ret;
BR
Sean

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
