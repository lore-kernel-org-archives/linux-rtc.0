Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370793B2AA
	for <linux-rtc@vger.kernel.org>; Fri,  9 Oct 2026 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791581602; cv=none; b=bYYw762ogIhnRZVK2nTFZdFUPBA10+x3i0AbiHu0yWTtQ7hKfTKIAnKzO/uVby0JoIB3Izo5AI6H3vggwisQYsxQ1/98fyKMA1VODOHhDexEWKmIfV6mJoY/a5Nt7eMmO5Oswj/vcv8hm+OBajqrJx+ideL8ZHKv2iPUiChidDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791581602; c=relaxed/simple;
	bh=dLNm75Os5LsS0z4bDhCf/5sfokluNe4QKBHZ3iXRcZo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KvGHmVjuW21Bk/XBvnaE66APWsLygx9+uUJc+tShkqL11Wc2c77Do2jAUeBDtvqAABuvGvjMrVKxMv6ZGQ+BpsSajx1ybWN0I14O7WSOseIJCca/dxxv4WBgRHOT6r7TQNxD7gD7f9h62+PoiebW5DwYwhDZZhYtBE1bN5CHUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evf0KJrs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evf0KJrs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91741F000FF;
	Fri,  9 Oct 2026 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791581601;
	bh=dLNm75Os5LsS0z4bDhCf/5sfokluNe4QKBHZ3iXRcZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Evf0KJrslHTDo286LRjSyIteQo1DV4AMGczflCrUwKQNqIvqyGkT1q/RaWQoiNqvy
	 Ps8MOGNKhxL2Y0aqQYBMtUc5LSXLti3V7yq5jJ740j71kdeVJmWIW/uk++u0X8fRMD
	 Q3OOZDVkEmpFZ2Zv4spMroAWszPY8X0fmao66cDE3aV7iOuvLUq6vnraA3zkoDgjdd
	 u7l18R3EPUznCDiBy7O2JEpDdlLXznS4Abedz828CflhltPkQeV1zFlp6yhjsjCtXd
	 b9p8GOWiajBfE7NwqCxGp2GMO7Ny0wpcS5DIPiR/r4FCFMGROWMJB8D5av6meXDjc6
	 QfHrOvvouWIeg==
Message-ID: <sashiko-outbox-166089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rtc: nvidia-vrs10: remove locking in IRQ handler
Reply-To: sashiko-reviews@lists.linux.dev
To: alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261009212347.490403-1-alexandre.belloni@bootlin.com>
References: <20261009212347.490403-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:33:20 +0000
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>=20
> Remove locking in the interrupt handler as it is not necessary to be lock=
ed
> while calling rtc_update_irq().
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009212347.4904=
03-1-alexandre.belloni@bootlin.com?part=3D1

