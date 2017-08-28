Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38229 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbdH1T6d (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 28 Aug 2017 15:58:33 -0400
Received: by mail-wr0-f195.google.com with SMTP id j3so980039wrb.5
        for <linux-rtc@vger.kernel.org>; Mon, 28 Aug 2017 12:58:32 -0700 (PDT)
Subject: Re: [PATCH] rtc: ds1307: improve weekday handling
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org
References: <57598a86-21c7-b354-2840-309563440435@gmail.com>
 <20170828191518.ofntjb2tknttjexq@piout.net>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <dea642c9-872e-1871-bdcd-13944d77d5be@gmail.com>
Date: Mon, 28 Aug 2017 21:58:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170828191518.ofntjb2tknttjexq@piout.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 28.08.2017 um 21:15 schrieb Alexandre Belloni:
> On 28/08/2017 at 20:37:21 +0200, Heiner Kallweit wrote:
>> mcp794xx as one chip supported by this driver needs the weekday for
>> alarm matching. RTC core ignores the weekday so we can't rely on
>> the values we receive in member tm_wday of struct rtc_time.
>> Therefore calculate the weekday from date/time when setting the
>> time and setting the alarm time for mcp794xx.
>>
>> When having this in place we don't have to check the weekday
>> at each driver load.
>> After a chip reset date/time and weekday may be out of sync but
>> in this case date/time need to be set anyway.
>>
> 
> Nope, the core issue is that you can actually set an alarm in the future
> without setting the time beforehand so this as to be fixed in the probe
> (this was the issue as reported at the time of the fix).
> 
Ah, found the original thread where this was discussed.
Still I don't really understand the problem. mcp794xx matches based on
secs, min, hour, wday, mday, month. When I use "rtcwake -s 5" I expect
the alarm to trigger 5 secs from now. How can this ever work if the
RTC has random date/time (wday being valid or not)?

I'd tend to say that if we know the RTC time is incorrect we shouldn't
allow setting an alarm.
At least I wouldn't dare to program a bomb explosion time if I stand in
front of it and know that the bomb's clock has a random value ;)

>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/rtc/rtc-ds1307.c | 39 +++++++++++++++------------------------
>>  1 file changed, 15 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
>> index 9d680d36..83b8c997 100644
>> --- a/drivers/rtc/rtc-ds1307.c
>> +++ b/drivers/rtc/rtc-ds1307.c
>> @@ -437,6 +437,18 @@ static int ds1307_get_time(struct device *dev, struct rtc_time *t)
>>  	return rtc_valid_tm(t);
>>  }
>>  
>> +/*
>> + * Certain chips need the weekday for alarm matching and tm->t_wday
>> + * may be not or not properly populated
>> + */
>> +static int ds1307_get_weekday(struct rtc_time *tm)
>> +{
>> +	time64_t secs64 = rtc_tm_to_time64(tm);
>> +	int days = div_s64(secs64, 24 * 60 * 60);
>> +
>> +	return (days + 4) % 7 + 1;
>> +}
>> +
>>  static int ds1307_set_time(struct device *dev, struct rtc_time *t)
>>  {
>>  	struct ds1307	*ds1307 = dev_get_drvdata(dev);
>> @@ -465,7 +477,7 @@ static int ds1307_set_time(struct device *dev, struct rtc_time *t)
>>  	regs[DS1307_REG_SECS] = bin2bcd(t->tm_sec);
>>  	regs[DS1307_REG_MIN] = bin2bcd(t->tm_min);
>>  	regs[DS1307_REG_HOUR] = bin2bcd(t->tm_hour);
>> -	regs[DS1307_REG_WDAY] = bin2bcd(t->tm_wday + 1);
>> +	regs[DS1307_REG_WDAY] = ds1307_get_weekday(t);
>>  	regs[DS1307_REG_MDAY] = bin2bcd(t->tm_mday);
>>  	regs[DS1307_REG_MONTH] = bin2bcd(t->tm_mon + 1);
>>  
>> @@ -902,7 +914,7 @@ static int mcp794xx_set_alarm(struct device *dev, struct rtc_wkalrm *t)
>>  	regs[3] = bin2bcd(t->time.tm_sec);
>>  	regs[4] = bin2bcd(t->time.tm_min);
>>  	regs[5] = bin2bcd(t->time.tm_hour);
>> -	regs[6] = bin2bcd(t->time.tm_wday + 1);
>> +	regs[6] = ds1307_get_weekday(&t->time);
>>  	regs[7] = bin2bcd(t->time.tm_mday);
>>  	regs[8] = bin2bcd(t->time.tm_mon + 1);
>>  
>> @@ -1355,14 +1367,12 @@ static int ds1307_probe(struct i2c_client *client,
>>  {
>>  	struct ds1307		*ds1307;
>>  	int			err = -ENODEV;
>> -	int			tmp, wday;
>> +	int			tmp;
>>  	const struct chip_desc	*chip;
>>  	bool			want_irq;
>>  	bool			ds1307_can_wakeup_device = false;
>>  	unsigned char		regs[8];
>>  	struct ds1307_platform_data *pdata = dev_get_platdata(&client->dev);
>> -	struct rtc_time		tm;
>> -	unsigned long		timestamp;
>>  	u8			trickle_charger_setup = 0;
>>  
>>  	ds1307 = devm_kzalloc(&client->dev, sizeof(struct ds1307), GFP_KERNEL);
>> @@ -1642,25 +1652,6 @@ static int ds1307_probe(struct i2c_client *client,
>>  			     bin2bcd(tmp));
>>  	}
>>  
>> -	/*
>> -	 * Some IPs have weekday reset value = 0x1 which might not correct
>> -	 * hence compute the wday using the current date/month/year values
>> -	 */
>> -	ds1307_get_time(ds1307->dev, &tm);
>> -	wday = tm.tm_wday;
>> -	timestamp = rtc_tm_to_time64(&tm);
>> -	rtc_time64_to_tm(timestamp, &tm);
>> -
>> -	/*
>> -	 * Check if reset wday is different from the computed wday
>> -	 * If different then set the wday which we computed using
>> -	 * timestamp
>> -	 */
>> -	if (wday != tm.tm_wday)
>> -		regmap_update_bits(ds1307->regmap, MCP794XX_REG_WEEKDAY,
>> -				   MCP794XX_REG_WEEKDAY_WDAY_MASK,
>> -				   tm.tm_wday + 1);
>> -
>>  	if (want_irq || ds1307_can_wakeup_device) {
>>  		device_set_wakeup_capable(ds1307->dev, true);
>>  		set_bit(HAS_ALARM, &ds1307->flags);
>> -- 
>> 2.14.1
>>
> 
