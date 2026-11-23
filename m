Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465987;
	b=hO202FbkEDBQdQ/karTkt5HoSVVHO0CsQmVIZzmZc/jG06oRNdm/NYYujOPG4lNFkeZx
	 +qdWqB0Ae4U10BuYaW2JsvEKQ15NTDJGycxukKcjlPZ4s6kInCj+m8P3Ftvsu5cLDTM+e
	 rLtF2NVtGXJ9gbUjerz1lfa7jf6dbXN/NaCP54OEseEyiTO71vQe0bdADw8es/lOWxYQT
	 5mqa93xL8/KYqC2L7HykRi5BIAZxYu8zai8LT+MMGLSieyrF5/gRiM5HK1zztQ2AXbwu6
	 NkG1H/coKTUjw8KqfN4z4xAWwLDEHtqrxEyDVbmHuLBtSkI4+QhFq+CIFmBTCgzbIDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465987;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/NSTMr+uT4cDF+16X1LskXdcCI7ABq9CnJN/D2X9gVY=;
	b=04oWdqpzcJ89lgo3WVuLoRTfMp2NLIboE3E0B3ZhKQmazudtSTsVWQUsSC/8Ar60Kcjg
	 js4WoKAtQpuvht6YWyV1umhM4rtM0XPJL6+NvP+G7cz2ZETQ3MW6N08HOV2D/aSnZIkGI
	 bO9nbAGCYD+Aq0vrQgCLJq5ZstLG49Hd2Q+t/CouKLesp4R/ELJTW1GJyoGzsjc18XgX+
	 cDia7oo4cBRhWYTFzIzuLDkpx7g5EKwvwAcxGHaZdvsilfQB78yBjjm5AA9A4KD5fP6bd
	 bXynZqrw+HXJVtzL2s6crqKOeJUV0U1aYkbEJk2H9PuQEkcOlb0cKix3TxjaH+Y8xuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opz66TJy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62AC606A330
	for <linux-rtc@vger.kernel.org>; Mon, 23 Nov 2026 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=opz66TJy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96B91F008B2;
	Mon, 23 Nov 2026 20:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795465986;
	bh=/NSTMr+uT4cDF+16X1LskXdcCI7ABq9CnJN/D2X9gVY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=opz66TJyafRfCek2GtN+wUyTyFU9cHC/9f8nhtZ1KmGZsfLBIQqSZewqbf/Ba8YH0
	 fsqgBhokKNQPNTwxD2J6klKXY2KoVHDkCaCis/all7nMtgw4MaT/YJOeWAwsIBf1wQ
	 RVuRQTRI16uIr2MEMIzRX+fBi23WLnwGkGsLXUVv+w7DGoai9jW7IiCMoH5RJrTKuO
	 SXEMMxC+ASED34go42ETS+ptQHrsTjAH9kEc8hgJCQ22IHMFPhyB8zDG4qK5TVTcA8
	 z1pzbMKsga2fI85nX7WtZnVLYdbqeKQBrHzumBZEok1gNfFm4ZgwOjApZ00wJ1nIyF
	 y/qB+flCxy47g==
Message-ID: <sashiko-outbox-230000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/3] rtc: Add Cortina Systems CS7542 calendar clock
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
References: <20261123-b4-cs7542-rtc-v2-0-31ab43f2cc8e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 20:33:06 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 3-patch series:

- Patches 1 and 2: no issues found.
- Patch 3: skipped (not reviewed).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-cs7542-=
rtc-v2-0-31ab43f2cc8e@gmail.com
