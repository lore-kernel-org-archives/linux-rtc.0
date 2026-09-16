Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F934F46F;
	Wed, 16 Sep 2026 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541808; cv=none; b=cciJz2laRVzuQmy73Tg4XHk3rQAZ09/eG/JqQbd8nbFsrdQvd9znl3A4BPJrpLmnHVkfPC7NiouJQX8/te8BALQbkAkGcXkcB/sN/u3vCZBAmU5nrPhjsmJucwQKQR3U3o3qCnN+VRK+5feMYfTwjibhrJz61+OO8KQagdpyg4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541808; c=relaxed/simple;
	bh=wHhuB6awHceWBN/yAYkFZYu89qnzgnm7Ng3vzMpjqkc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=I0hqQIlUmLNyzV/MIpIXlRv0uIkalhB4OP3VdfzQCMtroI8BAmP2mAbHpr/QvM1fXpQeSaz+XYK0KE+JS9CfCP31GN8BnCEzrtbOX45PizDM4k7g/B4yoYzzCjOweZOMMSAffLGDTmgmuvpk0Qkmlisl+Qx1agxPg8CbXYuUEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WJ5LGnmu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ElCBSZe8; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WJ5LGnmu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ElCBSZe8"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id E7E94EC0E95;
	Wed, 16 Sep 2026 02:56:45 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 16 Sep 2026 02:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789541805;
	 x=1789628205; bh=M79NB03lCBDyuKbFMw+wzNI/AjNtbOzIZ5eYbZXjn8c=; b=
	WJ5LGnmuEHCO96B4tiFDbDhlSXR+n/dc3QvQG2UOI3Opekg2OZ0DX0bfiGysncdE
	MgNN3dGco/ZCJhlo7pCIZEr/GbItFk+813mL0YcWF7CiAYFBgz72Xm4UdoWa5/1l
	TMdhsAnCZAVfBGhAfhZSltGgPpDr2bhgg2Bxt/t0isAXG1dHPqWsiAj0SgLsNKEB
	t2zSOXcBRpjAiymCXGBzc6LiZaezNaR+SaM4bL2CcfkNoDGYOZtB1xbn5ODSi2mG
	uwH9qZ0AR493QIm+nmdPaYeSsn8BvPS9XkU6+hWHp7aoVIepNQAZP8KI4GfZwBBX
	3ynwrdrRoXsMvS9y7m0KyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789541805; x=
	1789628205; bh=M79NB03lCBDyuKbFMw+wzNI/AjNtbOzIZ5eYbZXjn8c=; b=E
	lCBSZe8FrLDeKUFNMOuaMrDDgk3AL/vIWXFAb69pcQhNs4FbgiBbnaoE4TwBfo+3
	Sc0z3cyr+jmw6o1MR31/kFjZrnVJijaNP+bHYcN+dJglaruKRYmIJsbS+mhwueRJ
	vxACQ1Qac1d70wlW8UHPUQBXlonAIMVkv+oqGQfRQa5+i7A64Bar40sbqQxMNfs+
	yULTTR/gUUMzz2d03gjRg3HrYKkatQChJ455bljzw7H7QgW8WbIWPYxK+VwHFwx6
	axlcy22UWtFYJiNY1Y/wdSvtLvFRHL1VsE5XgwcBSrMdhT1jp5ifD8sGrPDQNpNf
	Ls7nmyDBE54/6aVFbLcqg==
X-ME-Sender: <xms:qz2qan2y-98uRn4numprGhlP8ao2tyqu3y92FNxrNaJGwrszuBslCw>
    <xme:qz2qag4hUk2hWTh0C__-Is6Q01zyJPdj4ship7k7iduUHeFE4CO942yTWVrXyp8z2
    wvPfm0qfCBeBMo-yve_E3TSI7EY20az7VqeMWsk921hc7b1eUMKZA>
X-ME-Proxy-Cause: dmFkZTGlTRixtFUqWRbDPcFeCYs4Rp+D05ekXbAePbvN1C3h3mmf+LVUTQrUNW4kFHUKKL
    HS49Ddxv6rHY5gTfoKBoR2IEie18wSginaEyEffpnhRXCh4ZgwoFELocO/Npxlr+Yh5Pod
    R8TbPsJ62tLt30X5PjsgKKF4sV6dHrBD69r7keXQzMa1RwOMmW5L329PLWMazbmNsLa2lU
    TqqgGd7KEhVAzA91RoaSMBwHxbTHrlUtsd8c6QvRjKhXog56s0yP8k82J0G68/XbfEkq4+
    eH1bhc5+FKxgyKnyRna5W6zdD+kHHsOn4f5ZOmygFB3jqi0PBd2yROoPrspq/QndL64rN7
    RtVu4C9Zn/wvn77OYoZpEBRQ+hjQX2FU7kVrKtwkxHD3waX8mhhZyZQqvO8oZUoECbIfGk
    AgIzy/7ntylRnKnn5zp/LCYpokI5+LZz1IoY8FnhvAE620kv83zAvfASGZ13QQ993VhFav
    Ke/nsP45dMfJ2kaIezjIZ/mUwk7ZtTiJoYqjL4AiIOqbz3bO7mUbAFaMmQsQVGtmF3eRxF
    yAR052ZdqwuPwnnMoI2oKpnsOOPZTHoN8xEEgHMqXnlh/ecGtzeoE2YkL9+09yTlTV6fvu
    6muPE1i4mYvshG8SboCntcOSoc8aMwaR6DfaPL7NvYeaHb/etG7spewKcYdg
X-ME-Proxy: <xmx:rD2qag_uPVXx-hWp9IizX1r-j3z7l2yPnyaExqCmr-LaNsoVc5M8yw>
    <xmx:rD2qakIkqrXNo4VSsQ4o8nDdbUE8VU7oOKW5ukayVNFx3pBTGiSNeA>
    <xmx:rD2qapjPx2ZVUZXu5LEzxYZlUsdGdslg7btCW8WW-D0jgE4DoryApw>
    <xmx:rD2qak7a4pKwayH7V8nDSGqFt88on2mRnhf2vJArbHieVOxqv8SgxA>
    <xmx:rT2qalrpmJOFgsaJfkGksq8BE0b7dCNgpwo3BJM7kiPA7zhFlQb1n8iG>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9824632A0084; Wed, 16 Sep 2026 02:56:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApDcdGHCsDIN
Date: Wed, 16 Sep 2026 08:56:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <59ba6707-c5d5-4fd8-9200-f910e61d9232@app.fastmail.com>
In-Reply-To: <aqnHDxRIBncNH6qr@gmail.com>
References: <20260914212537.1452-1-kmehltretter@gmail.com>
 <7c020979-cf03-4ece-a7d4-b1475d1400c3@app.fastmail.com>
 <aqnHDxRIBncNH6qr@gmail.com>
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 16, 2026, at 00:37, Karl Mehltretter wrote:
> On Tue, Sep 15, 2026 at 07:48:12AM +0100, Arnd Bergmann wrote:
>> On Mon, Sep 14, 2026, at 23:25, Karl Mehltretter wrote:
>> > On 32-bit systems with RTC_HCTOSYS enabled, rtc_hctosys() rejects
>> > RTC dates whose seconds value exceeds INT_MAX, even when userspace
>> > uses a 64-bit time_t. This leaves system time uninitialized by the RTC.
>> >
>> > Commit b3a5ac42ab18 ("rtc: hctosys: Ensure system time doesn't overflow
>> > time_t") introduced this limit to protect time32 userspace from future
>> > RTC dates that can break boot. The same limit prevents systems with
>> > time64 userspace from initializing the clock from valid post-2038 dates.
>> 
>> What about the reverse: if COMPAT_32BIT_TIME is disabled, I don't
>> see why we'd want to allow turning this on, so maybe
>
> I tried this and found a case where the limit may still be useful
> with COMPAT_32BIT_TIME=n. Glibc can use time64 kernel interfaces
> for applications with a 32-bit time_t. Conversion to time32 fails
> with EOVERFLOW when the date is out of range.
>
> I tested a small clock_gettime() program using Debian glibc 2.41
> on 32-bit ARM in QEMU, with identical kernel configurations and
> initramfs. With RTC_HCTOSYS=y, COMPAT_32BIT_TIME=n and RTC in 2040:
>
>   Kernel                 System year  time32 clock_gettime()
>   ---------------------  -----------  ---------------------
>   Baseline               1970         success
>   Patch with dependency  2040         -1, errno=EOVERFLOW

I think this is technically a bug in glibc: a task that calls the
time32 clock_gettime() is supposed to fail with
COMPAT_32BIT_TIME=n regardless of the date, according to the
original design. I understand that this is hard to do in
glibc based on how it deals with the three kernel variants
(time32 only v5.0 and older, time64-only with COMPAT_32BIT_TIME=n,
both present), but I still hope that we can one day do this
e.g. by having allowing glibc to be built without the time32
library interfaces to force a link failure.

> The legacy clock_gettime syscall returned ENOSYS in both cases.
> The same program built with a 64-bit time_t succeeded on both
> kernels. Both builds also succeeded with the RTC in 2026. Both
> kernels booted with time64 init.
>
> Disabling legacy syscalls therefore does not establish that all
> applications use a 64-bit time_t. The dependency would remove the
> existing safeguard automatically and prevent restoring it without
> re-enabling the legacy ABI.

I'm not following your logic here, what is the safeguard?

With a fixed C library, COMPAT_32BIT_TIME=n should act as a safeguard
to ensure that no interfaces can be used that limit time to y2038
and break unexpectedly in the future. The RTC_HCTOSYS interface
has so far always thrown a wrench into that because it still truncates
an important interface inside of the kernel. Your patch makes it
possible to do the right thing here, but one still has to know
that the Kconfig option exists and turn it off in order to
actually make it work. Since we have COMPAT_32BIT_TIME as a global
option already, it makes a lot of sense to actually use it here
as well.

       Arnd
