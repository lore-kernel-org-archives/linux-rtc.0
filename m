Return-Path: <SRS0=IPBj=NS=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6360C0044C
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Nov 2018 12:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991A420827
	for <linux-rtc@archiver.kernel.org>; Wed,  7 Nov 2018 12:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991A420827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-rtc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKGWTZ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:19:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37642 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeKGWTY (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 7 Nov 2018 17:19:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id y10-v6so6806832edr.4
        for <linux-rtc@vger.kernel.org>; Wed, 07 Nov 2018 04:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FmDANElFIbEy7TQHE+o/v6joh4X/61XNuR88WPwGNOw=;
        b=FTkoSLZT/9Y4kt4aW+MtqIGSWCnprf4uVsfpZlbref5krDzIg6QJzyO88lyWhklJtA
         EHgo4MMph1ACnZlUIoIctwKfkVO/K0kqkcWfqhsc2BfqN/kgJrFB5W4IFZgBSvUNwtw8
         OIixGDUo4PgGFuepwxJbApIBXBRqAt8pirw5KMEu+5P2aDOBWz4+MkcPryenOwzrWmOV
         YgSz89MGqmryjIAPPXzIa3dQC122/NllAtVQovxtQXV/33xFrmdXa3K7MCc1YnJfeze/
         H1Uu2Ea2m/SYv+aTGuaX+gy95gyyMSkw6Xacpnx7jN4+lS79EfjCusCnA/RFPEn0YClK
         SQQw==
X-Gm-Message-State: AGRZ1gIaOd4B6YKYicntRg3fSgepab2Dm7wJ2yAB74HjxrdOi5NEsEzn
        v7T7AV2lxBaF/OC7WQFZMEv6GCQMLb4=
X-Google-Smtp-Source: AJdET5eLiQ5WdeLp+OZA2bNIqTwQZcTmVZAvclj4CjKgzet/QO87f+KOHS454jkFrXRYpphlZ5+TRw==
X-Received: by 2002:a50:9226:: with SMTP id i35-v6mr98627eda.50.1541594947439;
        Wed, 07 Nov 2018 04:49:07 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id br3-v6sm129707ejb.24.2018.11.07.04.49.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 04:49:06 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] rtc: cmos: Do not export alarm rtc_ops when we do not
 support alarms
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20180904145129.17098-1-hdegoede@redhat.com>
 <20180908143735.GC2598@piout.net>
Cc:     linux-rtc@vger.kernel.org
Message-ID: <4fd4ff2f-41ad-4695-0c38-64c2bc0b936e@redhat.com>
Date:   Wed, 7 Nov 2018 13:49:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20180908143735.GC2598@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi,

On 08-09-18 16:37, Alexandre Belloni wrote:
> On 04/09/2018 16:51:29+0200, Hans de Goede wrote:
>> When there is no IRQ configured for the RTC, the rtc-cmos code does not
>> support alarms, all alarm rtc_ops fail with -EIO / -EINVAL.
>>
>> The rtc-core expects a rtc driver which does not support rtc alarms to
>> not have alarm ops at all. Otherwise the wakealarm sysfs attr will read
>> as empty rather then returning an error, making it impossible for
>> userspace to find out beforehand if alarms are supported.
>>
>> A system without an IRQ for the RTC before this patch:
>> [root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
>> [root@localhost ~]#
>>
>> After this patch:
>> [root@localhost ~]# cat /sys/class/rtc/rtc0/wakealarm
>> cat: /sys/class/rtc/rtc0/wakealarm: No such file or directory
>> [root@localhost ~]#
>>
>> This fixes gnome-session + systemd trying to use suspend-then-hibernate,
>> which causes systemd to abort the suspend when writing the RTC alarm fails.
>>
>> BugLink: https://github.com/systemd/systemd/issues/9988
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/rtc/rtc-cmos.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
> Applied, thanks.

I'm not seeing this patch in 4.20-rc1 and it is not in

https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/log/?h=rtc-next

So it seems that this one has fallen through the cracks?

Regards,

Hans

