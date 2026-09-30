Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76E1E1A3D;
	Wed, 30 Sep 2026 01:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730493; cv=none; b=C/dDOaLiJPH+KNv0nZVVlIs4ejmhtCZmXi60mJGcPeWc0+x0eGMQR7fsHxzKwUJPL3zAe1ijn7rwjFFsNptMTNeXfvwvXXZniHzAiVkEdKvB3oYAwB9drBehpIYLR1mvHVwUpmsClWh6A7StBXuVXBieX4NcS6AJjBc2b0Rx7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730493; c=relaxed/simple;
	bh=70J7NNdFN9iAGf3Qj3JyXlavrQs1w70uu+ZcCSB862w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwqyetztZj5L6SxYfrc2hOhaB907UphSDjddGwAor9WsnAqsMM3D202WKGIAMj4vmpzncF0I+zRPfUIqBf57muUxhICFKRirQ8eAeefH3SGmu8ScoxND9lyQI3F+9A3pBEI6ZaBMVnu+Zoa1e+tLEwU/+cI5oAF6ds3dJi5OKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn; spf=pass smtp.mailfrom=kylinsec.com.cn; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpsz6t1790730460t0f88200f
X-QQ-Originating-IP: OwcfBdNuqctd8CjiAUHOXhQcKMNZu3TocnKPXxHAhGQ=
Received: from [192.168.21.56] ( [111.8.45.130])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 30 Sep 2026 09:07:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8595862658938292285
EX-QQ-RecipientCnt: 6
Message-ID: <E7FFA319011BB387+42ce8b1d-eafe-4cfd-8711-a783b4e068f0@kylinsec.com.cn>
Date: Wed, 30 Sep 2026 09:07:37 +0800
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: rs5c372: add missing error code for unknown RTC type
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deng Yingchao <dengyingchao@kylinsec.com.cn>,
 Qin Yungao <qinyungao@kylinsec.com.cn>, Luo Qiu <luoqiu@kylinsec.com.cn>
References: <C18300C5767FC690+20260827015846.3314353-1-liudalin@kylinsec.com.cn>
 <2026092921481727857dc7@mail.local>
Content-Language: en-US
From: liudalin <liudalin@kylinsec.com.cn>
In-Reply-To: <2026092921481727857dc7@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NSVxyzdiwvnqcyhdX/1KNK14ZSuKaddh6FANlULDrhBfirme/fBOKSNd
	sVDdEC2orii49lVwODPhSNoMveNnr2M2wT+y8BXiJkfLmd+qNmHPKDQRAx7wVXgK+U645AS
	yN7tbq0PCnYBsMHcKqwnNZC1WY0EvI2vB2j9xdEvp7v/ya1/a91dEHGqTiKuGvY9CGBxuYh
	/1IHZ5NWRoJoP4Xzky4dPpfcpiBPsBX81vFd3r5DAEY/0reyblCkwYZ05Ko2M8hOMXvJOpC
	VdMZmjT6v7oyKt4cEZPxgr9h5+Qnqpp/soNYuVyP5d20r9unGI/V6lgMCcKMRyIeFC2VYoV
	6BM/ivTT5NlblkpTZRZOiqR5oW1WX84NtQzgllaZlW9hbA4m2ljnT8DE3CtVBgsVcecdg/4
	I2fE80avT2frnI0s2EUhifGs0oK892tFmd/WmzPyq23aSuJsDW1sQqUws4wQntnkyrdZU/c
	ZUGsMaQmkkKGFtHKbYt1dsNc9dU9yfSv+KzGykaPRWwJZOlqCuP3nUE8lzbepGEMnzMNHDH
	QTvtwFNGturglRRlPcczu94lAEp4xaXGYoOzt9HbRtUArhJ21nJnY/pxMnmDaVNAsqKZulB
	+TLRmmzg+vzYQQ5tLURtApD1iou2VU14paNr/xvLZ3fcIymX6dG/RZ5krcPqqIKZNl4olcJ
	Zv+WaFbkZuR+GeXPeQHd7/vZ1Z74zW/DWszr5W5NNVRXDYyozJRyiXkJ9ro+fPROopCnmr4
	9EklKk5KIvEIXQMFwZkAdabYi+HTOjru2ZfynOqZAR/mur6fDMvNPSFTbbxCyXn0ysi27ng
	Ck89O3XUFyQcTG1QdNw4868PSuFRmSrezc9VBPoFv3EwKIZr0/2tCGldBay+TCVm9ZohJmg
	PZhBNzfLFw2rDO/ULdKYBauU6eFxrrZwBa9Z1Ga4D6NWOhYZPVtnhe8D1RTrpCQ/txsJm2j
	tSf+Qm71yL2IL+9SMfYDKalKp07/GWGJnaTwduSnhe3UzQPuUB7zQKfc0tDNbLFXie475FX
	BZjBbhcBSielT6adffdbYZZk0uuCxi5SsQGwUWNPoklh5LwIs3NrSbx2el8/KUUvmQQXBmg
	JpEtMi/ZEmEszjJ/G7Q6MM=
X-QQ-XMRINFO: OD9hHCdaPRBwhLtWeuGpOsVHN6RvCZWPxQ==
X-QQ-RECHKSPAM: 0


在 2026/9/30 05:48, Alexandre Belloni 写道:
> On 27/08/2026 09:58:46+0800, Liu Dalin wrote:
>> In rs5c372_probe(), when an unknown RTC type is encountered in the
>> switch default case, the local variable 'err' is still 0 from its
>> initialization. The subsequent goto to the exit label then returns
>> success, even though probe has failed.
>>
>> Set err = -ENODEV before jumping to exit to properly report the
>> failure to the caller.
>>
>> Fixes smatch warnings:
>> - drivers/rtc/rtc-rs5c372.c:860 rs5c372_probe() warn: missing error
>>    code 'err'
>>
>> Fixes: cb26b572dc394 ("[PATCH] Update the rtc-rs5c372 driver")
>> Assisted-by: smatch:2.0 [static analysis]
>> Signed-off-by: Liu Dalin <liudalin@kylinsec.com.cn>
>> ---
>>   drivers/rtc/rtc-rs5c372.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
>> index 24bd795d9d95..84407119caba 100644
>> --- a/drivers/rtc/rtc-rs5c372.c
>> +++ b/drivers/rtc/rtc-rs5c372.c
>> @@ -857,6 +857,7 @@ static int rs5c372_probe(struct i2c_client *client)
>>   		break;
>>   	default:
>>   		dev_err(&client->dev, "unknown RTC type\n");
>> +		err = -ENODEV;
> But isn't this dead code that will never be reached? In what case would
> you be probed and not match any i2c_device_id?

Thanks for reviewing.

You are correct that the default case is dead code for current driver logic.

Alternatively we could remove the default case entirely, but keeping it 
with proper error assignment is safer for future maintenance.


