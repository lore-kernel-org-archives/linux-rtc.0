Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DD3D669F;
	Sat, 19 Sep 2026 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789809426; cv=none; b=Z1KPO2Q4J0W15AWWWhl3C4UMvPg+H/nzGDWG/2e97ie/GkdwBsx5tBchK2EzsxT5hgvGiCt0WvxMSK301me0lx20nbVkDfIcdSNReYU8yxD8WhGsjMpzt/ibs7mGU+zRhS0iXYamsgfhWLzlFXvPnUlLtE/SBk66BNTnM6GVroI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789809426; c=relaxed/simple;
	bh=cYORSXUuqD65c95GY1/n/DazfXF+Xhi5Ptoc+KjPJl8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=soYgohrH5HTWUEwLD6T2f8bFsHfoycEdU6ej4BwjgIfx09txOJAZ99Yrj6rZTId97LCu1y5Vf+mXDBWDh5kPZ3yPN6u5/18X7YKT4aIdTFWBBJnorp8t0anoAjiSKhrKDAipevTK+t97ZMQYVcKG11tgI0Xy/MJIl+6NMBw86ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fd7vQLhw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rOf28EPd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fd7vQLhw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rOf28EPd"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C029214000A1;
	Sat, 19 Sep 2026 05:17:02 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sat, 19 Sep 2026 05:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789809422;
	 x=1789895822; bh=TVGm/Byj3e+AhQkHso7bisUdHCmm5Mg4iVX1NG0/Mrs=; b=
	fd7vQLhwyiBHxxSzBltEX2iDGxTikqqRm5fv25y6SM0LgNn51X0kjD4E2AEvyZx8
	dANDDRyUJdW22PBMUvj9xJDgKUiH0CK3NzO9G4dLp0o10NVMLaCFcOIQ+wIb/jtr
	+JNFQ9AzH8CDLU79b6PlGOvDBQ45vfMoVeAw2Iv1MFXfiqDEv2Le96OXqfzK4dyl
	PcOHaFGBz7MAACBcqMje92N9PuUsow57XfXjMEP78YxrmfcoimJyV5KiB5C+henm
	7JYSb4b1jbEjanf6S5QDjKe+vm2efM2zo0knPRmogPpmwk7eMQMmm+VxkX9qfxhH
	C/hSP08F1ntCgGqdfMF++Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789809422; x=
	1789895822; bh=TVGm/Byj3e+AhQkHso7bisUdHCmm5Mg4iVX1NG0/Mrs=; b=r
	Of28EPdtrX+7VUeUSOKn7+ap6F/OoWEs9KZWGfUX6M3jghxTAd4MrvDUFuRIN1US
	zAD1v/nLGTHP6i/gU+s1PI4RQmTwsU+T43bcVa8GssrJwLzy/D6gNemkKM7fhVCz
	0eqbAebszCps59ORyCGJ53s13Bhp4bL6L2vI0CKHIl4md4P8s4OWIjKZUveIiISE
	z73qKrFbqn8tKNsvULWRHQrU5wonQIvHgOPoStjV/qBTs/HlogZ148Fn9QoIxZSp
	dFpjHyKOAt1TR6BJYbISY0tNtcZP/RUpyqqqQtE5sw2eAHX5rpbS2ZbCAxSHiwu5
	u1Y2DtN/IPPm5WWSfxqTQ==
X-ME-Sender: <xms:DFOuajmdIy3skBeDg3c80dUvbqjNS56Jcmb45vBTd4WL8acNErQIrQ>
    <xme:DFOuahr7hXG08GcX3xYbver4vKcXNMXr2THf5-X417Eqe2-QRvwQtu3F_fg8Wp70H
    ZHEjZSjYPKoeCal7MSSu8ITFeg4v7B9lYBO8LqHjfDteZdXpfkQIQ>
X-ME-Proxy-Cause: dmFkZTExHf1X7OumjBwuK2pkmw/F3OmI/Rh5w17UJ360JwlWT0zd8dDj4wSfKK6qtf9DXV
    QULra5QczBVRwKg2ZvVtAKEutL5kNNUFEr7ZdYCp7o4DrzzVF4cfGcKMXfNLNvzbd9oBR0
    x+EHuZbNjMlWAHWYWGO86RbjEA4tvBvxH4GxTWSRAi+YMU47k9ZvndFvZo0r3yCJ0CQ9Hf
    TKbTVPg3HFxVBZ2lFIecqfbjyvcfJ8FEiixc2h5eZrZtDuADneWIPiYLHcmHHQgrnUSO9u
    suI9/xmCMZAJsX5x9GHxwM0fAT6KpTM5yv0GIGCbpDQLCgXejRUHLUed81WmZI56xY9yK0
    5ScHrwWLHiBvmAVNJJco/j3oTOIToAsvphvWzERGVcQyjDFnkMNWpGlsZj4FieNsQBgeWE
    QUG/BHBQzaN8P5NKpxDB2s4hxf7io7TazR9sD6+l87qEgKumBP6rV+yYCB2ulkL4+895Z5
    5UwTsX8x0oF2t2MwD7lypBXiXtIudoejaxXp0LjBYYsBQHD+snIJAmZxDgbTIy0K1DXgGB
    QLUXCDmK1sIg/J7BvU2YBxzQTT/Uwcbp4lWA94k/JDEz8J4HcOGeuWwoepEfvCQh1i/D90
    WExckfg27f+bmsB6R8W3Dab7+xNOQvHYYy1kGMSV4ON7l8lcIQNKX9P5BQPg
X-ME-Proxy: <xmx:DFOuamvxkpWoBPkTAIFD48t-W2mmRutnQc2EjAz_N5PkJo6ZFLgxLQ>
    <xmx:DFOuam46sVstmzXjUWHHI_NbJmIGF44ubL969F91dSknUPXD0a3_Sw>
    <xmx:DFOualTIRw5-Yfj0K4aI0yImOF4czpOxCtmqx_HX_Z_m19EXySKYlQ>
    <xmx:DFOualqqKDOHxOs1drCVxd567lndPMRIaFAyJpcVaM0O_2cyoZNzAg>
    <xmx:DlOuaqanCGBRigPn6WnPoUfKv_shbuRjELoXRjdxQrd82B7O6-sYq2GQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id F115D32A0087; Sat, 19 Sep 2026 05:16:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ApDcdGHCsDIN
Date: Sat, 19 Sep 2026 11:16:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5515c266-f9cd-405f-b7a8-1ec45d9d902a@app.fastmail.com>
In-Reply-To: <aq3R5QnCpu_fOq8g@gmail.com>
References: <20260914212537.1452-1-kmehltretter@gmail.com>
 <7c020979-cf03-4ece-a7d4-b1475d1400c3@app.fastmail.com>
 <aqnHDxRIBncNH6qr@gmail.com>
 <59ba6707-c5d5-4fd8-9200-f910e61d9232@app.fastmail.com>
 <aq3R5QnCpu_fOq8g@gmail.com>
Subject: Re: [PATCH] rtc: class: Make the time32 hctosys limit configurable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Sep 19, 2026, at 02:10, Karl Mehltretter wrote:
> On Wed, Sep 16, 2026 at 08:56:02AM +0100, Arnd Bergmann wrote:
>> > existing safeguard automatically and prevent restoring it without
>> > re-enabling the legacy ABI.
>> 
>> I'm not following your logic here, what is the safeguard?
>
> I meant the existing RTC cutoff. In my glibc test, accepting the
> 2040 RTC date changes time32 clock_gettime() from success to
> EOVERFLOW.

I see. I would just not call that a safeguard, it's more of a
time bomb ;-)

Note that the cutoff was never meant to help systems actually
run beyond 2038, but instead is only needed on very rare systems
with a broken RTC implementation that have a random reset
value if the RTC is enabled in devicetree but the backup battery
is absent or depleted.

>> With a fixed C library, COMPAT_32BIT_TIME=n should act as a safeguard
>> to ensure that no interfaces can be used that limit time to y2038
>> and break unexpectedly in the future. The RTC_HCTOSYS interface
>
> Should we try adding an option to build glibc and other libcs without
> time32 interfaces? Looking at musl's source, its time32 clock_gettime()
> wrapper also calls the time64 implementation and checks whether the
> result fits [1].

I think that would be great, we can certainly try again, at least
with glibc, where at the time the concern was more about the timing
of behavior changes.

There are two separate questions here:

a) Having a libc build only against the time64 interfaces. As far
   as I understand, glibc has used linux-3.2 headers as the
   baseline for kernel compatibility for a long time but one can
   choose a later version. Building with 5.10+ as the minimum
   should already avoid the time32 syscalls, but that could at
   some point be made the minimum header version for 32-bit targets
   or everything.
   musl does not specify a minimum kernel version at all and tries
   to go back as far as possible, so the fallback code is likely
   to stay indefinitely. Rich also does not like the idea of setting
   CONFIG_COMPAT_32BIT_TIME=n (ever), and an unpatched musl
   build will fail in that configuration.
   
b) providing 32-bit interfaces to applications: both libraries
   already provide these as wrappers around the 64-bit internal
   functions, which is part of the problem here but does mean that
   it should be possible to just leave those out. On musl this
   should be very easy (just skip building the compat/time32/
   directory), on glibc I expect this to be much harder as it
   interferes with their idea of having __TIMESIZE=64 vs
   __TIMESIZE=32 as a hardcoded per-architecture setting.

>> actually make it work. Since we have COMPAT_32BIT_TIME as a global
>> option already, it makes a lot of sense to actually use it here
>> as well.
>
> Could we use COMPAT_32BIT_TIME for the default, but still allow the
> limit to be enabled? I could split the update into two patches:
>
> 1. Add RTC_HCTOSYS_TIME32_LIMIT with default y, as posted. This keeps
>    the existing RTC date acceptance by default.
>
> 2. Change the default, keeping the dependency unchanged:
>
>        depends on RTC_HCTOSYS && !64BIT
>        default COMPAT_32BIT_TIME
>
> With RTC_HCTOSYS=y on a 32-bit kernel, the default would allow
> post-2038 RTC dates when COMPAT_32BIT_TIME=n. Integrators could still
> enable the limit without re-enabling legacy syscalls.
>
> I suggest nominating the first patch for stable. Would default
> COMPAT_32BIT_TIME also be suitable for stable?

I think the 'default COMPAT_32BIT_TIME' would absolutely make
sense for stable, since that can only really be set by users that
have a fully 64-bit userspace already and the limit will
cause problems for them.
I would still go one step further and make this

config RTC_HCTOSYS_TIME32_LIMIT
	bool "Reject RTC dates after the 2038 cutoff"
	depends on RTC_HCTOSYS && !64BIT && COMPAT_32BIT_TIME
	default y

to completely disallow it. I think we should wait for Alexandre
to comment here, as it's his subsystem in the end and I'm sure
he has an opinion on the matter.

     Arnd
